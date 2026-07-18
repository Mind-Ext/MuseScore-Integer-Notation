function keySigToPitchClass(keySig) {
    const offsetToClass = [0, 7, 2, 9, 4, 11, 6, 1, 8, 3, 10, 5]
    return offsetToClass[(keySig + 12) % 12]
}

function keySigToNoteNames(keySig) {
    // positive: sharp
    // negative: flat
    // [major, minor]
    const mapping = {
        "0": ["C", "A"],
        "1": ["G", "E"],
        "2": ["D", "B"],
        "3": ["A", "F#"],
        "4": ["E", "C#"],
        "5": ["B", "G#"],
        "6": ["F#", "D#"],
        "7": ["C#", "A#"],
        "-1": ["F", "D"],
        "-2": ["Bb", "G"],
        "-3": ["Eb", "C"],
        "-4": ["Ab", "F"],
        "-5": ["Db", "Bb"],
        "-6": ["Gb", "Eb"],
        "-7": ["Cb", "Ab"]
    }
    return mapping[keySig.toString()]
}

function noteNumToNoteName(n) {
    const noteNames = ["C", "C#/Db", "D", "D#/Eb", "E", "F", "F#/Gb", "G", "G#/Ab", "A", "A#/Bb", "B"]
    return noteNames[(n + 1200) % 12]
}

function getNoteTextFormats(formatIndex, pitchClass) {
    return [
        ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11"],
        ["1", "b2", "2", "b3", "3", "4", "b5", "5", "b6", "6", "b7", "7"],
        ["1", "#1", "2", "#2", "3", "4", "#4", "5", "#5", "6", "#6", "7"]
    ][formatIndex][pitchClass]
}

function getKeySigText() {
    var cursor = curScore.newCursor()
    if (curScore.selection.elements.length) {
        cursor.rewind(Cursor.SELECTION_START)
    } else {
        cursor.rewind(Cursor.SCORE_START)
    }
    // rewind prevents crash on 4.6
    var keySigOffset = cursor.keySignature
    var prefix = "{{inital_key}}"
    if (isNaN(keySigOffset)) {
        return prefix + "{{unknown}}"
    }
    var pitchClass = keySigToPitchClass(keySigOffset)
    var noteNames = keySigToNoteNames(keySigOffset)

    var keySigText = `${noteNames[0]}{{ key_signature_major_label }} / ${noteNames[1]}{{ key_signature_minor_label }}`
    if (keySigOffset != 0) {
        const symbol = keySigOffset > 0 ? "#" : "b"
        // const symbol = keySigOffset > 0 ? "♯" : "♭"
        keySigText = `(${symbol}×${Math.abs(keySigOffset)}) ${keySigText}`
    }

    var refNote = pitchClass + 60
    if (refNote >= 67) {
        refNote -= 12
    }
    var oct = Math.floor(refNote / 12) - 1
    // special case for Cb (C4=60, Cb4=59, B3=59)
    if (noteNames[0] == "Cb") {
        oct += 1
    }
    inputReferenceNote.value = refNote
    return `${prefix}${keySigText}, ${noteNames[0]}${oct}=${refNote}`
}

function getNoteText(pitchClass) {
    let noteText = getNoteTextFormats(inputNotationFormat.currentIndex, pitchClass)
    if (useSymbolAccidentals()) {
        // Strip text accidental prefix; native symbol will be added separately
        noteText = noteText.replace(/^[#b]+/, "")
    } else {
        noteText = formatScaleDegreeText(noteText)
    }
    return noteText
}

function useSymbolAccidentals() {
    if (inputNotationFormat.currentIndex === 0) return false
    if (typeof inputAccidentalStyle !== "undefined") {
        return inputAccidentalStyle.currentIndex === 1
    }
    return false
}

function getScaleDegreeAccidentalCount(pitchClass) {
    let formatIndex = inputNotationFormat.currentIndex
    if (formatIndex === 0) return 0
    let noteText = getNoteTextFormats(formatIndex, pitchClass)
    if (noteText[0] === "b") return -1
    if (noteText[0] === "#") return 1
    return 0
}

function formatScaleDegreeText(noteText) {
    let match = /^([#b]+)(.+)$/.exec(noteText)
    if (match) {
        noteText = "<sup>" + match[1] + "</sup>" + match[2]
    }
    return noteText
}

function getRefNote(initialKeySig, currKeySig) {
    let pc1 = keySigToPitchClass(initialKeySig)
    let pc2 = keySigToPitchClass(currKeySig)
    let offset = inputFollowKeyChange.checked ? (pc2 + 12 - pc1) % 12 : 0
    if (offset > 6) {
        offset -= 12
    }
    return inputReferenceNote.value + offset
}

function createNoteTextForPitch(notePitch, refNote) {
    let relPitchClass = (notePitch - refNote + 1200) % 12
    let relativeOctave = Math.floor((notePitch - refNote) / 12)
    let dot = "•"
    let text = ""
    if (relativeOctave > 0 && inputOctaveDots.checked)
        text += "<sup>" + dot.repeat(relativeOctave) + "</sup>"
    if (relativeOctave < 0 && inputOctaveDots.checked)
        text += "<sub>" + dot.repeat(-relativeOctave) + "</sub>"
    text += getNoteText(relPitchClass)
    return text
}

function createRefNoteSigText(initialKeySig, currKeySig) {
    let pc1 = keySigToPitchClass(initialKeySig)
    let pc2 = keySigToPitchClass(currKeySig)
    let keyChangeOffset = inputFollowKeyChange.checked ? (pc2 + 12 - pc1) % 12 : 0
    if (keyChangeOffset > 6) {
        keyChangeOffset -= 12
    }
    let newRefNote = inputReferenceNote.value + keyChangeOffset
    let [keyNameMajor, keyNameMinor] = ["", ""]
    if (newRefNote % 12 === pc1) {
        [keyNameMajor, keyNameMinor] = keySigToNoteNames(initialKeySig)
    } else if (newRefNote % 12 === pc2) {
        [keyNameMajor, keyNameMinor] = keySigToNoteNames(currKeySig)
    } else {
        keyNameMajor = noteNumToNoteName(newRefNote)
        keyNameMinor = noteNumToNoteName(newRefNote - 3)
    }
    let keyName = keyNameMajor
    let prefix = ""
    let octave = ""
    let suffix = ""
    if (inputRefSigFormat.currentIndex == 0) {
        prefix += inputNotationFormat.currentIndex == 0 ? "0=" : "1="
        // major key
    } else if (inputRefSigFormat.currentIndex == 1) {
        prefix += inputNotationFormat.currentIndex == 0 ? "9=" : "6="
        keyName = keyNameMinor
        // minor key
        newRefNote += 9
    }
    if (inputOctaveDots.checked) {
        octave = Math.floor(newRefNote / 12) - 1
        if (keyName == "Cb") {
            octave += 1
        }
        suffix = ` (${newRefNote})`
    }
    let el = newElement(Element.STAFF_TEXT)
    el.text = `${prefix}${keyName}${octave}${suffix}`
    return el
}

function buildOttavaCache() {
    const cache = []
    const pitchShifts = [12, -12, 24, -24, 36, -36]

    // MS 4.7 new property spanners https://github.com/musescore/MuseScore/pull/31060
    let elements = curScore.spanners || curScore.selection.elements

    // 2. Populate the cache (works for both user selection or full score)
    for (let i = 0; i < elements.length; i++) {
        const el = elements[i]

        // Note: In some newer MS4 versions, selections return OTTAVA_SEGMENT 
        // instead of OTTAVA, so it is safest to check for both
        if (el.type === Element.OTTAVA || el.type === Element.OTTAVA_SEGMENT) {

            // If it's a segment, we need its parent Spanner to get the true type
            const spanner = (el.type === Element.OTTAVA_SEGMENT) ? el.spanner : el
            const oT = spanner.ottavaType

            const shift = (oT >= 0 && oT < pitchShifts.length) ? pitchShifts[oT] : 0

            cache.push({
                staff: Math.floor(spanner.track / 4),
                start: spanner.spannerTick.ticks,
                end: spanner.spannerTick.ticks + spanner.spannerTicks.ticks,
                pitchShift: shift
            })
        }
    }

    return cache
}

function getOttavaShift(tick, staffIdx, ottavaCache) {
    let shift = 0
    for (let i = 0; i < ottavaCache.length; i++) {
        const ottava = ottavaCache[i]
        if (staffIdx === ottava.staff && tick >= ottava.start && tick < ottava.end) {
            shift = ottava.pitchShift
        }
    }
    return shift
}

function mainShared(processChord) {
    let fullScore = !curScore.selection.elements.length
    if (fullScore) {
        cmd("select-all")
    }
    let cursor = curScore.newCursor()
    cursor.rewind(Cursor.SELECTION_START)
    let startStaff = cursor.staffIdx
    cursor.rewind(Cursor.SELECTION_END)
    let endStaff = cursor.staffIdx
    let endTick = cursor.tick == 0 ? curScore.lastSegment.tick + 1 : cursor.tick

    cursor.rewind(Cursor.SELECTION_START)
    let initialKeySig = cursor.keySignature
    let prevKeySig
    let currKeySig

    const ottavaCache = buildOttavaCache()

    for (let staff = startStaff; staff <= endStaff; staff++) {
        for (let voice = 0; voice < 4; voice++) {
            cursor.rewind(Cursor.SELECTION_START)
            cursor.voice = voice
            cursor.staffIdx = staff

            while (cursor.segment && cursor.tick < endTick) {
                if (cursor.element
                    && (cursor.element.type == Element.CHORD
                        || cursor.element.type == Element.REST)) {
                    currKeySig = cursor.keySignature
                    if (prevKeySig !== currKeySig) {
                        if (inputRefSigFormat.currentIndex !== 2 && voice === 0 && staff === 0) {
                            if (inputFollowKeyChange.checked || prevKeySig === undefined) {
                                cursor.add(createRefNoteSigText(initialKeySig, currKeySig))
                            }
                        }
                        prevKeySig = currKeySig
                    }
                }
                if (cursor.element && cursor.element.type == Element.CHORD) {
                    const pitchShift = getOttavaShift(cursor.tick, staff, ottavaCache)
                    processChord(cursor, cursor.element, initialKeySig, currKeySig, staff, pitchShift)
                }
                cursor.next()
            }
        }
    }
    if (fullScore) {
        cmd("escape")
    }
}
