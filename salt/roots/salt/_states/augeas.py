from salt.exceptions import CommandExecutionError, CommandNotFoundError

def __virtual__():
    return 'augeas' if 'augeas.setvalue' in __salt__ else False


def value(name, value, **kwargs):
    ret = {
        'name': name,
        'result': True,
        'comment': '',
        'changes': {}
    }

    if not isinstance(value, basestring):
        ret['result'] = False
        ret['comment'] = "{0} should be a string value".format(value)
        return ret

    try:
        values = __salt__['augeas.get'](name)
        old_value = values[name]
    except (CommandExecutionError, CommandNotFoundError) as e:
        ret['result'] = False
        ret['comment'] = "Could not find value for '{0}': {1}".format(name, e)
        return ret

    changed = (value != old_value)

    if not changed:
        ret['comment'] = "'{0}' already set to '{1}'".format(name, value)
        return ret

    if __opts__['test']:
        ret['result'] = None
        ret['comment'] = "'{0}' will be set to '{1}'".format(name, value)
        return ret

    try:
        __salt__['augeas.setvalue'](name, value)
    except (CommandExecutionError, CommandNotFoundError) as e:
        ret['result'] = False
        ret['comment'] = "Could not update value for '{0}' to '{1}': {2}".format(name, value, e)
        return ret

    ret['changes']['old'] = old_value
    ret['changes']['new'] = value
    ret['comment'] = "'{0}' set to '{1}'".format(name, value)
    return ret
