"""Read PAK evidence; optional decoded previews go only into Output, never runtime."""
import sys, struct, json, ctypes, hashlib
from pathlib import Path
from prepare_npc_restoration import PakReader, rows, pak_id

ROOT = Path(__file__).resolve().parents[1]
def get_payload(reader, logical):
    entry = reader.index.get(pak_id(logical.encode('gbk')))
    if entry and logical.lower().endswith('.spr') and not entry[4]&0x10000000:
        pak,n,size,pos,flags=entry
        if pak not in reader.handles:
            handle=reader.dll.CreatePak()
            if reader.dll.PakLoad(handle,str(pak).encode('mbcs'))<=0: raise ValueError(str(pak))
            reader.handles[pak]=handle
        buf=ctypes.create_string_buffer(size)
        if reader.dll.PakReadBlock(reader.handles[pak],n,buf,size)!=size: raise ValueError(logical)
        return buf.raw, dict(logical=logical,pak=pak.name,entry=n,id=f'{pak_id(logical.encode("gbk")):08X}',sha256=hashlib.sha256(buf.raw).hexdigest())
    return reader.get(logical)

def main():
    reader = PakReader(ROOT.parent / 'PhongThanRuntime-Content/Client',
        ROOT.parent / 'SeaweedUnpack_SprView/SeaweedUnpack_SprView/UnpackCore.dll')
    try:
        preview='--preview' in sys.argv
        for logical in [x for x in sys.argv[1:] if x!='--preview']:
            found = get_payload(reader,logical)
            if not found:
                print('MISSING', logical); continue
            data, proof = found
            print(json.dumps(proof, ensure_ascii=False))
            if logical.lower().endswith('.spr'):
                print('SPRHEAD', struct.unpack_from('<4s12H', data))
                if preview and len(data)>32:
                    # PakReadBlock returns indexed RLE here; decode without resizing.
                    from PIL import Image
                    frames=struct.unpack_from('<H',data,12)[0]
                    colors=struct.unpack_from('<H',data,14)[0]
                    table=32+colors*3
                    off,length=struct.unpack_from('<II',data,table)
                    block=data[table+frames*8+off:table+frames*8+off+length]
                    palette=[tuple(data[32+i*3:35+i*3]) for i in range(colors)]
                    w,h,x,y=struct.unpack_from('<4H',block)
                    pixels=[];p=8
                    while len(pixels)<w*h:
                        run,alpha=block[p:p+2];p+=2
                        if not run or len(pixels)+run>w*h: raise ValueError('invalid run')
                        for i in range(run):
                            rgb=palette[block[p]] if alpha else (0,0,0)
                            if alpha:p+=1
                            pixels.append(rgb+(alpha,))
                    pic=Image.new('RGBA',(w,h));pic.putdata(pixels)
                    out=ROOT/'Output/EquipmentPresentation'/f'{pak_id(logical.encode("gbk")):08X}.png'
                    out.parent.mkdir(parents=True,exist_ok=True);pic.save(out)
                    print('PREVIEW',out,'frame',w,h,x,y)
            else:
                records=rows(data)
                print('COLUMNS', [(n+1,c.decode('gbk',errors='replace')) for n,c in enumerate(records[0])])
                for n, row in enumerate(records[1:13],2):
                    print('ROW', n, [c.decode('gbk',errors='replace') for c in row])
    finally:
        reader.close()

if __name__=='__main__':
    sys.stdout.reconfigure(encoding='utf8')
    main()
