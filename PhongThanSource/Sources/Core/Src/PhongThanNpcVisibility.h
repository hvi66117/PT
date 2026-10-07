#ifndef PHONGTHAN_NPC_VISIBILITY_H
#define PHONGTHAN_NPC_VISIBILITY_H
// MPS projects Y at half scale. Cover the 1024x768 viewport plus sprites
// and a prefetch margin; a Euclidean 800-MPS circle cuts off visible corners.
// The caller visits only the current region and its eight neighbours.
inline bool PhongThanNpcInView(int deltaX, int deltaY)
{
    return deltaX >= -768 && deltaX <= 768 &&
           deltaY >= -1280 && deltaY <= 1280;
}
#endif
