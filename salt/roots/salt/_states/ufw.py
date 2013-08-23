from salt.exceptions import CommandExecutionError, CommandNotFoundError
import re
import socket


def _unchanged(name, msg):
    return {'name': name, 'result': True, 'comment': msg, 'changes': {}}


def _test(name, msg):
    return {'name': name, 'result': None, 'comment': msg, 'changes': {}}


def _error(name, msg):
    return {'name': name, 'result': False, 'comment': msg, 'changes': {}}


def _changed(name, msg, **changes):
    return {'name': name, 'result': True, 'comment': msg, 'changes': changes}


def _resolve(host):
    # pure IP address / netmask IPv4 or IPv6 ?
    if re.match(r'^([0-9\.](::))+(/[0-9]+)?$', host):
        return

    return socket.gethostbyname(host)


def _as_rule(method, app, protocol, from_addr, from_port, to_addr, to_port):
    cmd = [method]
    if app is not None:
        cmd.append(app)
    else:
        if protocol is not None:
            cmd.append("proto")
            cmd.append(protocol)

        cmd.append("from")
        if from_addr is not None:
            cmd.append(_resolve(from_addr))
        else:
            cmd.append("any")

        if from_port is not None:
            cmd.append("port")
            cmd.append(_resolve(from_port))

        cmd.append("to")
        if to_addr is not None:
            cmd.append(to_addr)
        else:
            cmd.append("any")

        if to_port is not None:
            cmd.append("port")
            cmd.append(to_port)
    real_cmd = ' '.join(cmd)
    return real_cmd


def enabled(name, **kwargs):
    if __salt__['ufw.is_enabled']():
        return _unchanged(name, "UFW is already enabled")

    if __opts__['test']:
        return _test(name, "UFW will be enabled")

    try:
        __salt__['ufw.set_enabled'](True)
    except (CommandExecutionError, CommandNotFoundError) as e:
        return _error(name, e.message)

    return _changed(name, "UFW is enabled", enabled=True)


def allowed(name, app=None, protocol=None,
            from_addr=None, from_port=None, to_addr=None, to_port=None):

    rule = _as_rule("allow", app=app, protocol=protocol,
                   from_addr=from_addr, from_port=from_port, to_addr=to_addr, to_port=to_port)

    if __opts__['test']:
        return _test(name, "{0}: {1}".format(name, rule))

    try:
        out = __salt__['ufw.add_rule'](rule)
    except (CommandExecutionError, CommandNotFoundError) as e:
        return _error(name, e.message)

    changes = False
    for line in out.split('\n'):
        if line.startswith("Skipping"):
            continue
        changes = True
        break

    if changes:
        return _changed(name, "{0} allowed".format(name), rule=rule)
    else:
        return _unchanged(name, "{0} was already allowed".format(name))

