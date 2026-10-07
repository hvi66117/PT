# Login transport buffer fix

Goddess read PhongThanNpc state=4644 successfully but SendData returned E_FAIL. Heaven factory constructed transport buffers with the ServerStage.h default of 3072 bytes; its separately configured cache was larger. Previous 2768-byte state fit; the expanded inventory did not.

Factory transport allocation is now 65536 bytes. SendData rejects payloads beyond 65535 minus WORD framing. Aggregate flush threshold uses min(transport, cache)-32, preventing overflow of the smaller write cache.

Built Heaven and published synchronized runtime. Goddess now reports send=0 and GameServer reports send_game_data_flush hr=0/login_data_sent. Service probe received native self snapshot, sync fence and inventory snapshots. Probe did NOT pass final self-vitals acknowledgement (timeout); do not call this full graphical login acceptance. Probe's missing-Core fallback now sizes fixed legacy login control packets explicitly.

Runtime was restarted and graphical client reopened after probes to clear test sessions. Character data and inventory were not deleted or truncated. Native frame format remains WORD-sized; supporting near-64KiB character-state envelopes needs a separate segmentation design.
