#ifndef PHONGTHAN_SET_ACTIVATION_H
#define PHONGTHAN_SET_ACTIVATION_H
// Project policy: three pieces expose three effects, four expose four;
// a complete five-piece set exposes every configured effect, not five only.
inline int PhongThanActiveSetEffectCount(int pieces, int effects)
{
    if(pieces<3 || effects<=0)return 0;
    if(pieces>=5)return effects;
    return pieces<effects ? pieces : effects;
}
#endif
