# announcer

This is a shared library for Garry's Mod for announcing events with global voice lines, with support for multiple languages and announcers.

Although this is a shared library, the clientside portion of it does most of the work, including adding announcers - the server only concerns itself with broadcasting announcements to players.

# Examples

```lua
if !CLIENT then return end
announcer.Add("ut99", {
	headshot = "vo/announcer/ut99/headshot.ogg",
})
```

This will add the announcer `ut99` *(Unreal Tournament 1999)* with a voice line called `headshot` that points to a sound file. If this announcer already existed, the `headshot` voice line would either be updated or added, depending on whether the voice line already existed prior to calling this.

Also, if this is the first announcer being added via `announcer.Add`, then `ut99` will become the selected announcer for clients by default.

```lua
if !CLIENT then return end
ANNOUNCEMENT_HEADSHOT = 0
announcer.Add("ut99", {
	[ANNOUNCEMENT_HEADSHOT] = "vo/announcer/ut99/headshot.ogg",
})
```

This is identical to the previous example, except the announcer's voice lines became sequential by using an enumeration (`ANNOUNCEMENT_HEADSHOT` instead of `"headshot"`). **Enumerations are the recommended way to index voice lines**.

```lua
if !CLIENT then return end
announcer.Select "ut99"
```

This will select the `ut99` announcer for future announcements. This will return true if the announcer was succesfully selected, false otherwise. False can be returned if:

+ The announcer is already selected.
+ The announcer doesn't exist.

```lua
if !SERVER then return end
ANNOUNCEMENT_HEADSHOT = 0
announcer.Broadcast(ANNOUNCEMENT_HEADSHOT)
```

This will broadcast the headshot voice line to every player on the server, and if the client has an announcer selected that has the headshot line added, it will be played to the client globally.

Alternatively, you can provide players to broadcast to exclusively as either a single player or a table of players for the second argument, or multiple players across as many additional arguments as needed.

## License

This is licensed under the [DBAD License](license.md).
