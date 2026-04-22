from kitty.boss import Boss
from kitty.window import Window


def on_focus_change(boss: Boss, window: Window, data: dict) -> None:
    if not data.get('focused'):
        return
    if window.user_vars.get('workmux_auto_clear') == '1':
        boss.call_remote_control(window, (
            'set-user-vars', f'--match=id:{window.id}',
            'workmux_status=', 'workmux_auto_clear=',
        ))


def on_set_user_var(boss: Boss, window: Window, data: dict) -> None:
    if data.get('key') == 'workmux_status':
        tm = boss.os_window_map.get(window.os_window_id)
        if tm is not None:
            tm.update_tab_bar_data()
            tm.mark_tab_bar_dirty()
