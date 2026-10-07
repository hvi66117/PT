#ifndef PHONGTHAN_ITEM_SERIES_H
#define PHONGTHAN_ITEM_SERIES_H
// Resolve VNG's template marker without truncating it to an 8-bit wire value.
inline int PhongThanResolveItemSeries(int templateSeries, int requestedSeries,
    int seriesCount, int neutralSeries)
{
    if(templateSeries!=1000)return templateSeries;
    return requestedSeries>=0 && requestedSeries<seriesCount ? requestedSeries : neutralSeries;
}
#endif
