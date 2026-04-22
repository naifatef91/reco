# Android Support Call Recorder MVP

## Product Scope
- Platform: Android only.
- Recording source: device phone calls (incoming and outgoing).
- Storage policy: local storage only.
- Support workflow: recordings can be reviewed, tagged, and documented by support staff.

## Core User Stories
1. As a support agent, I can see call recordings with date, duration, and number.
2. As a support agent, I can open a recording, play it, and add support notes.
3. As a support agent, I can search recordings by number or note text.
4. As an admin user, I can enforce consent and legal notice before recording starts.

## Compliance Constraints
- The app must show legal consent text before enabling recording.
- Call recording capability depends on OEM restrictions and Android version behavior.
- The app must degrade gracefully when two-way audio capture is unavailable.

## Definition Of Done For MVP
- Foreground service monitors call state and attempts recording.
- Metadata persists in Room and survives reboot.
- Audio files are written locally and encrypted before persistence.
- UI supports list, filter, detail, playback, note editing, and status updates.
