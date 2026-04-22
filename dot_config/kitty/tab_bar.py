from kitty.fast_data_types import get_boss


def draw_title(data):
    tab = get_boss().tab_for_id(data['tab'].tab_id)
    if tab:
        for window in tab:
            status = window.user_vars.get('workmux_status', '')
            if status:
                return ' ' + status
    return ''
