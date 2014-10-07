## Diary Utilities

I try to keep a regular diary. I use a file per day, per 'theme', e.g. 2014-10-04-personal.md and 2014-10-04-work.md.

This repo contains some scripts that I'm playing with to help me explore the data I'm creating.

## Useful aliases

    $ alias today='date "+%Y-%m-%d"'
    $ alias last-monday='date -v"-Monday" -v"-7d" +%Y-%m-%d'
    $ alias this-monday='date -v"-Monday" +%Y-%m-%d'

## Useful commands

    # Display all last week's work entries in TextMate
    $ find . \
      -name "*-work.md" \
      -newerBt "`last-monday`" \
      -not -newerBt "`this-monday`" \
      | xargs cat \
      | mate

