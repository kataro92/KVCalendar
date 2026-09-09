import Testing
import EffectCore

struct EffectResolverTests {
    private let national = EffectCue(
        id: "cue-quoc-khanh",
        triggerOccurrenceID: "quoc-khanh",
        tone: "festive-solemn",
        priority: 100,
        nationalFlag: true,
        noConfetti: true,
        fallbackPosterID: "poster-quoc-khanh"
    )
    private let spring = EffectCue(
        id: "cue-lap-xuan",
        triggerSolarTermIndex: 21,
        tone: "quiet-spring",
        priority: 80,
        fallbackPosterID: "poster-lap-xuan"
    )
    private let memorial = EffectCue(
        id: "cue-hung-kings",
        triggerOccurrenceID: "gio-to-hung-vuong",
        tone: "solemn",
        priority: 90,
        solemn: true,
        noConfetti: true,
        noAudio: true,
        posterOnly: true,
        fallbackPosterID: "poster-hung-kings"
    )
    private let ordinary = EffectCue(
        id: "cue-ordinary",
        tone: "quiet-house",
        priority: 1,
        fallbackPosterID: "poster-ordinary"
    )

    private var cues: [EffectCue] { [national, spring, memorial, ordinary] }

    @Test func overlappingEventsKeepASingleHero() {
        let scene = EffectResolver.resolve(
            EffectResolverInput(
                occurrenceIDs: ["quoc-khanh", "gio-to-hung-vuong"],
                solarTermIndex: 21,
                cues: cues
            )
        )
        #expect(scene.heroCueID == "cue-quoc-khanh")
        #expect(scene.allowsConfetti == false)
    }

    @Test func solemnToneBlocksConfettiAndAudio() {
        let scene = EffectResolver.resolve(
            EffectResolverInput(occurrenceIDs: ["gio-to-hung-vuong"], cues: cues)
        )
        #expect(scene.heroCueID == "cue-hung-kings")
        #expect(scene.allowsConfetti == false)
        #expect(scene.allowsAudio == false)
        #expect(scene.quality == .resolvedStatic)
    }

    @Test func reduceMotionUsesPosterAndKeepsCue() {
        let scene = EffectResolver.resolve(
            EffectResolverInput(
                occurrenceIDs: ["quoc-khanh"],
                cues: cues,
                effectLevel: .vivid,
                reduceMotion: true
            )
        )
        #expect(scene.quality == .resolvedStatic)
        #expect(scene.heroCueID == "cue-quoc-khanh")
        #expect(scene.posterID == "poster-quoc-khanh")
    }

    @Test func introPlaysOncePerDayUnlessReplay() {
        let first = EffectResolver.resolve(
            EffectResolverInput(occurrenceIDs: ["quoc-khanh"], cues: cues, introSeenToday: false)
        )
        let later = EffectResolver.resolve(
            EffectResolverInput(occurrenceIDs: ["quoc-khanh"], cues: cues, introSeenToday: true)
        )
        let replay = EffectResolver.resolve(
            EffectResolverInput(
                occurrenceIDs: ["quoc-khanh"],
                cues: cues,
                introSeenToday: true,
                replayRequested: true
            )
        )
        #expect(first.introPlays)
        #expect(later.introPlays == false)
        #expect(replay.introPlays)
    }

    @Test func ordinaryDayWhenNoSpecificTrigger() {
        let scene = EffectResolver.resolve(
            EffectResolverInput(occurrenceIDs: [], cues: cues)
        )
        #expect(scene.heroCueID == "cue-ordinary")
    }

    @Test func missingAssetFallsBackToPosterWithoutDroppingCue() {
        let scene = EffectResolver.resolve(
            EffectResolverInput(
                occurrenceIDs: ["quoc-khanh"],
                cues: cues,
                missingAssetIDs: ["poster-quoc-khanh"]
            )
        )
        #expect(scene.quality == .resolvedStatic)
        #expect(scene.fallbackReason == "missing-asset")
        #expect(scene.heroCueID == "cue-quoc-khanh")
    }
}

struct VietnamFlagGeometryTests {
    @Test func aspectIsThreeByTwo() {
        let size = VietnamFlagGeometry.flagSize(hoist: 100)
        #expect(abs(size.width / size.height - VietnamFlagGeometry.flyOverHoist) < 1e-9)
        #expect(VietnamFlagGeometry.flyOverHoist == 1.5)
    }

    @Test func starHasFiveUpwardPointsAndStaysInside() {
        let size = VietnamFlagGeometry.flagSize(hoist: 200)
        let vertices = VietnamFlagGeometry.starVertices(width: size.width, height: size.height)
        #expect(vertices.count == 10)
        #expect(VietnamFlagGeometry.isPointingUp(vertices))
        #expect(VietnamFlagGeometry.allVerticesInsideFlag(vertices, width: size.width, height: size.height))
        let center = VietnamFlagGeometry.starCenter(width: size.width, height: size.height)
        #expect(abs(center.x - size.width / 2) < 1e-9)
        #expect(abs(center.y - size.height / 2) < 1e-9)
    }
}
