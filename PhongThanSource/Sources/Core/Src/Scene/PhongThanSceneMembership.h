#ifndef PHONGTHAN_SCENE_MEMBERSHIP_H
#define PHONGTHAN_SCENE_MEMBERSHIP_H
// Fell()/Clear() can detach a runtime leaf without changing its world anchor.
// A nonzero handle is ownership of the leaf, NOT proof it is in the draw tree.
template<class Leaf>
inline bool PhongThanSceneNeedsAttach(const Leaf* leaf, int x, int adjustedY)
{
    return (!leaf->pParentBranch && !leaf->pParentLeaf) ||
           leaf->oPosition.x != x || leaf->oPosition.y != adjustedY;
}
#endif
