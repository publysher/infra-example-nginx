"""
Execution module for UFW.
"""
def is_enabled():
    cmd = 'ufw status | grep "Status: active"'
    out = __salt__['cmd.run'](cmd)
    return True if out else False


def set_enabled(enabled):
    cmd = 'ufw --force enable' if enabled else 'ufw disable'
    __salt__['cmd.run'](cmd)


def add_rule(rule):
    cmd = "ufw " + rule
    out = __salt__['cmd.run'](cmd)
    __salt__['cmd.run']("ufw reload")
    return out
