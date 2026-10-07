// Selection must be updated before dispatch. The ACTIVE notification can
// destroy the complete dialog, including this list; do not access it afterwards.
void KWndMessageListBox::OnLButtonDown(int x, int y)
{
    const int selected = HitTextAtPoint(x, y);
    m_nSelMsgIndex = selected;
    if (selected >= 0 && m_pParentWnd)
        m_pParentWnd->WndProc(WND_N_LIST_ITEM_ACTIVE,
            (unsigned int)(KWndWindow*)this, selected);
}
