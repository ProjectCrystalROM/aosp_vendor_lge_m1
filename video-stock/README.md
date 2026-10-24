# K7 Venus firmware selection

Complete matched MS33010m stock Venus bundle from the archived stock system.
The focused radio product selects these seven files instead of its older
proprietary/etc/firmware copies. See provenance.json for SHA-256 hashes.
No other firmware family or library is substituted.

On 2026-10-24 the owner approved temporary file overlays. Normal trusted
firmware loading then reached "venus: Brought out of reset" instead of the
previous init_image metadata failure. With stock K7 H.264/AAC profiles, the
existing Qualcomm AVC encoder declaration, and a framework restart to clear
Zygote's cached profiles, rear 720p recording saved and played with sound.
The inspected MP4 contained AVC video and AAC audio. This qualifies that live
test; a persistent ROM still requires manual flash/cold-boot regression.
