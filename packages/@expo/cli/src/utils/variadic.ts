import * as Log from '../log';
import { CommandError } from '../utils/errors';

/** Given a list of CLI args, return a sorted set of args based on categories used in a complex command. */
export function parseVariadicArguments(argv: string[]): {
  variadic: string[];
  extras: string[];
  flags: Record<string, boolean>;
} {
  const variadic: string[] = [];
  const flags: Record<string, boolean> = {};

  for (const arg of argv) {
    if (!arg.startsWith('-')) {
      variadic.push(arg);
    } else if (arg === '--') {
      break;
    } else {
      flags[arg] = true;
    }
  }

  // Everything after `--` that is not an option is passed to the underlying install command.
  const extras: string[] = [];

  const extraOperator = argv.indexOf('--');
  if (extraOperator > -1 && argv.length > extraOperator + 1) {
    const extraArgs = argv.slice(extraOperator + 1);
    if (extraArgs.includes('--')) {
      throw new CommandError('BAD_ARGS', 'Unexpected multiple --');
    }
    extras.push(...extraArgs);
    Log.debug('Extra arguments: ' + extras.join(', '));
  }

  Log.debug(`Parsed arguments (variadic: %O, flags: %O, extra: %O)`, variadic, flags, extras);

  return {
    variadic,
    flags,
    extras,
  };
}

export function assertUnexpectedObjectKeys(keys: string[], obj: Record<string, any>): void {
  const unexpectedKeys = Object.keys(obj).filter((key) => !keys.includes(key));
  if (unexpectedKeys.length > 0) {
    throw new CommandError('BAD_ARGS', `Unexpected: ${unexpectedKeys.join(', ')}`);
  }
}
