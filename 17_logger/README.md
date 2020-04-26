# README
Demonstrates how to use a bash logger.

This one is taken from [tfenv](https://github.com/tfutils/tfenv)

## Example
```sh
./use_logger.sh
```

## Bashlog Logging Library Features

##### `BASHLOG_COLOURS`

Integer (Default: 1)

To disable colouring of console output, set to 0.


##### `BASHLOG_DATE_FORMAT`

String (Default: +%F %T)

The display format for the date as passed to the `date` binary to generate a datestamp used as a prefix to:

* `FILE` type log file lines.
* Each console output line when `BASHLOG_EXTRA=1`

##### `BASHLOG_EXTRA`

Integer (Default: 0)

By default, console output from tfenv does not print a date stamp or log severity.

To enable this functionality, making normal output equivalent to FILE log output, set to 1.

##### `BASHLOG_FILE`

Integer (Default: 0)

Set to 1 to enable plain text logging to file (FILE type logging).

The default path for log files is defined by /tmp/$(basename $0).log
Each executable logs to its own file.

e.g.

```console
BASHLOG_FILE=1 tfenv use latest
```

will log to `/tmp/tfenv-use.log`

##### `BASHLOG_FILE_PATH`

String (Default: /tmp/$(basename ${0}).log)

To specify a single file as the target for all FILE type logging regardless of the executing script.

##### `BASHLOG_I_PROMISE_TO_BE_CAREFUL_CUSTOM_EVAL_PREFIX`

String (Default: "")

*BE CAREFUL - MISUSE WILL DESTROY EVERYTHING YOU EVER LOVED*

This variable allows you to pass a string containing a command that will be executed using `eval` in order to produce a prefix to each console output line, and each FILE type log entry.

e.g.

```console
BASHLOG_I_PROMISE_TO_BE_CAREFUL_CUSTOM_EVAL_PREFIX='echo "${$$} "'
```
will prefix every log line with the calling process' PID.

##### `BASHLOG_JSON`

Integer (Default: 0)

Set to 1 to enable JSON logging to file (JSON type logging).

The default path for log files is defined by /tmp/$(basename $0).log.json
Each executable logs to its own file.

e.g.

```console
BASHLOG_JSON=1 tfenv use latest
```

will log in JSON format to `/tmp/tfenv-use.log.json`

JSON log content:

`{"timestamp":"<date +%s>","level":"<log-level>","message":"<log-content>"}`

##### `BASHLOG_JSON_PATH`

String (Default: /tmp/$(basename ${0}).log.json)

To specify a single file as the target for all JSON type logging regardless of the executing script.

##### `BASHLOG_SYSLOG`

Integer (Default: 0)

To log to syslog using the `logger` binary, set this to 1.

The basic functionality is thus:

```console
local tag="${BASHLOG_SYSLOG_TAG:-$(basename "${0}")}";
local facility="${BASHLOG_SYSLOG_FACILITY:-local0}";
local pid="${$}";

logger --id="${pid}" -t "${tag}" -p "${facility}.${severity}" "${syslog_line}"
```

##### `BASHLOG_SYSLOG_FACILITY`

String (Default: local0)

The syslog facility to specify when using SYSLOG type logging.

##### `BASHLOG_SYSLOG_TAG`

String (Default: $(basename $0))

The syslog tag to specify when using SYSLOG type logging.

Defaults to the PID of the calling process.

