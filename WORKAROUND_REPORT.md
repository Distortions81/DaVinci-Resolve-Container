# Linux shortcut workaround report

## Status

Confirmed working in this environment.

## Change applied

The Codex desktop keybinding for realtime voice was changed from a
`Command`-based accelerator to the cross-platform `CmdOrCtrl` form.

## Result

On Linux, the `Command` modifier may be treated as inactive.  The previous
binding could therefore be registered as an unmodified key and cause the
desktop application to crash when the matching key was typed.  After changing
the binding and restarting the application, the shortcut no longer produces
that failure.

The user subsequently confirmed that the application has continued working
well since the configuration change, with no recurrence of the crash.
