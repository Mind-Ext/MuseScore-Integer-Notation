//==============================================
//  Integer Notation & Numbered Notation plugin for MuseScore4
//
//  This program is free software: you can redistribute it and/or modify
//  it under the terms of the GNU General Public License as published by
//  the Free Software Foundation, either version 3 of the License, or
//  (at your option) any later version.
//
//  This program is distributed in the hope that it will be useful,
//  but WITHOUT ANY WARRANTY; without even the implied warranty of
//  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
//  GNU General Public License for more details.
//
//  You should have received a copy of the GNU General Public License
//  along with this program.  If not, see <http://www.gnu.org/licenses/>.
//==============================================

import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import MuseScore 3.0


MuseScore {
    version: "0.9.0 (465)"
    title: qsTr("Integer Notation")
    menuPath: "Plugins." + qsTr("Integer Notation")
    description: qsTr("Replace noteheads with Integer Notation or Numbered Notation")
    pluginType: "dialog"
    width: 320  // menu window size
    height: 600

    Settings {
        id: settings
        category: "IntegerNotationInside"
        property alias notationFormat: inputNotationFormat.currentIndex
        // property alias referenceNote: inputReferenceNote.value // do not persist
        property alias refSigFormat: inputRefSigFormat.currentIndex
        property alias followKeyChange: inputFollowKeyChange.checked
        property alias octaveDots: inputOctaveDots.checked
        property alias noteheadLeft: inputNoteheadLeft.checked
        property alias reposition: inputReposition.currentIndex
        property alias fontSize: inputFontSize.text
        property alias fontFace: inputFontFace.text
        property alias textColor: inputTextColor.text
        property alias xOffset: inputXOffset.text
        property alias hideMethod: inputHideMethod.currentIndex
        property alias color: inputColor.text
        property alias styleGroup: inputStyleGroup.currentIndex
    }

    ColumnLayout {
        id: column1
        x: 10
        y: 10
        width: parent.width - 20
        height: parent.height - 20

        RowLayout {
            id: rowFormat
            width: parent.width
            Label {
                text: "Notation format"
                Layout.fillWidth: true
            }
            ComboBox {
                id: inputNotationFormat
                Layout.alignment: Qt.AlignRight
                Layout.preferredWidth: 100
                currentIndex: 0
                model: ListModel {
                    ListElement {
                        text: "0~11"
                    }
                    ListElement {
                        text: "1~7,♭"
                    }
                    ListElement {
                        text: "1~7,♯"
                    }
                }
            }
        }

        RowLayout {
            Label {
                text: "Reference Note (MIDI C4=60)"
                Layout.fillWidth: true
            }
            SpinBox {
                id: inputReferenceNote
                from: 0
                to: 127
                stepSize: 1
                value: 60
                Layout.preferredWidth: 60
                Layout.alignment: Qt.AlignRight
            }
        }
        RowLayout {
            Label {
                text: getKeySigText()
                Layout.fillWidth: true
            }
        }
        RowLayout {
            Label {
                text: "Reference note signature"
                Layout.fillWidth: true
            }
            ComboBox {
                id: inputRefSigFormat
                Layout.alignment: Qt.AlignRight
                Layout.preferredWidth: 100
                currentIndex: 0
                model: ListModel {
                    ListElement {
                        text: "1st degree"
                    }
                    ListElement {
                        text: "6th degree"
                    }
                    ListElement {
                        text: "None"
                    }
                }
            }
        }
        RowLayout {
            Label {
                text: "Reference note follows key change"
                Layout.fillWidth: true
            }
            CheckBox {
                id: inputFollowKeyChange
                text: ""
                checked: true
                Layout.alignment: Qt.AlignRight
            }
        }
        RowLayout {
            Label {
                text: "Show octave dots (like Jianpu)"
                Layout.fillWidth: true
            }
            CheckBox {
                id: inputOctaveDots
                text: ""
                checked: true
                Layout.alignment: Qt.AlignRight
            }
        }
        RowLayout {
            Label {
                text: "Set noteheads to the left of stems"
                Layout.fillWidth: true
            }
            CheckBox {
                id: inputNoteheadLeft
                text: ""
                checked: false
                Layout.alignment: Qt.AlignRight
            }
        }
        RowLayout {
            Label {
                text: "Re-position notes vertically"
                Layout.fillWidth: true
            }
            ComboBox {
                id: inputReposition
                model: ["None", "Top align", "Bottom align"]
                Layout.alignment: Qt.AlignRight
                Layout.preferredWidth: 100
            }
        }
        Rectangle {
            width: parent.width
            height: 2
            color: "transparent"
        }
        Rectangle {
            width: parent.width
            height: 1
            color: "#cccccc"
        }
        Rectangle {
            width: parent.width
            height: 2
            color: "transparent"
        }

        RowLayout {
            Label {
                text: "Text size"
                Layout.fillWidth: true
            }
            TextField {
                id: inputFontSize
                text: "9.5"
                selectByMouse: true
                Layout.preferredWidth: 60
                Layout.alignment: Qt.AlignRight
            }
        }

        RowLayout {
            Label {
                text: "Text font"
                Layout.fillWidth: true
            }
            TextField {
                id: inputFontFace
                text: "Arial Narrow"
                selectByMouse: true
                Layout.preferredWidth: 100
                Layout.alignment: Qt.AlignRight
            }
        }

        RowLayout {
            Label {
                text: "Text color (RGB value)"
                Layout.fillWidth: true
            }
            TextField {
                id: inputTextColor
                text: "#000000"
                selectByMouse: true
                Layout.preferredWidth: 60
                Layout.alignment: Qt.AlignRight
            }
        }

        RowLayout {
            Label {
                text: "X offset"
                Layout.fillWidth: true
            }
            TextField {
                id: inputXOffset
                text: "1"
                selectByMouse: true
                Layout.preferredWidth: 60
                Layout.alignment: Qt.AlignRight
            }
        }

        RowLayout {
            Label {
                text: "Method to hide notehead"
                Layout.fillWidth: true
            }
            ComboBox {
                currentIndex: 0
                id: inputHideMethod
                model: ListModel {
                    property var key
                    ListElement {
                        text: "color"
                    }
                    ListElement {
                        text: "visibility"
                    }
                }
                Layout.preferredWidth: 100
                Layout.alignment: Qt.AlignRight
            }
        }

        RowLayout {
            Label {
                text: "Notehead color (RGB value)"
                Layout.fillWidth: true
            }
            TextField {
                id: inputColor
                text: "#f9f9f9"
                selectByMouse: true
                Layout.preferredWidth: 60
                Layout.alignment: Qt.AlignRight
                enabled: (inputHideMethod.currentIndex == 0)
            }
        }

        RowLayout {
            Label {
                text: "Text style"
                Layout.fillWidth: true
            }
            ComboBox {
                id: inputStyleGroup
                currentIndex: 0
                textRole: "text"
                model: ListModel {
                    ListElement {
                        text: "Custom-12"
                        value: -1
                    }
                    ListElement {
                        text: "User-1"
                        value: 49
                    }
                    ListElement {
                        text: "User-2"
                        value: 50
                    }
                    ListElement {
                        text: "User-3"
                        value: 51
                    }
                    ListElement {
                        text: "User-4"
                        value: 52
                    }
                    ListElement {
                        text: "User-5"
                        value: 53
                    }
                    ListElement {
                        text: "User-6"
                        value: 54
                    }
                    ListElement {
                        text: "User-7"
                        value: 55
                    }
                    ListElement {
                        text: "User-8"
                        value: 56
                    }
                    ListElement {
                        text: "User-9"
                        value: 57
                    }
                    ListElement {
                        text: "User-10"
                        value: 58
                    }
                    ListElement {
                        text: "User-11"
                        value: 59
                    }
                    ListElement {
                        text: "User-12"
                        value: 60
                    }
                }
                Layout.preferredWidth: 100
                Layout.alignment: Qt.AlignRight
            }
        }

        RowLayout {
            Label {
                font.pointSize: 10
                text: "v" + version
                Layout.fillWidth: true
            }
            Button {
                Layout.alignment: Qt.AlignRight
                Layout.preferredWidth: 80
                text: "Cancel"
                onClicked: {
                    quit()
                }
            }
            Button {
                Layout.alignment: Qt.AlignRight
                Layout.preferredWidth: 80
                text: "OK"
                onClicked: {
                    // quit first, otherwise cmd() won't work
                    // https://musescore.org/en/node/372762
                    quit()
                    curScore.startCmd()
                    main()
                    curScore.endCmd()
                }
                highlighted: true
            }
        }
    }

    onRun: {
        if (typeof curScore === 'undefined')
            quit()
    }

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

    function getKeySigText() {
        var cursor = curScore.newCursor()
        if (curScore.selection.elements.length) {
            cursor.rewind(Cursor.SELECTION_START)
        } else {
            cursor.rewind(Cursor.SCORE_START)
        }
        // rewind prevents crash on 4.6
        var keySigOffset = cursor.keySignature
        var prefix = "  Initial key "
        if (isNaN(keySigOffset)) {
            return prefix + "unknown"
        }
        var pitchClass = keySigToPitchClass(keySigOffset)
        var noteNames = keySigToNoteNames(keySigOffset)

        var keySigText = `${noteNames[0]} Maj / ${noteNames[1]} min`
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
        let formats = []
        formats.push(["0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11"])
        formats.push(["1", "b2", "2", "b3", "3", "4", "b5", "5", "b6", "6", "b7", "7"])
        formats.push(["1", "#1", "2", "#2", "3", "4", "#4", "5", "#5", "6", "#6", "7"])
        let notation = formats[inputNotationFormat.currentIndex]
        let noteText = notation[pitchClass]
        if ("#b".includes(noteText[0])) {
            noteText = "<sup>" + noteText[0] + "</sup>" + noteText[1]
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

    function formatText(textEl, isGrace) {
        if (inputStyleGroup.currentIndex == 0) {
            // as of MS 4.4, 59 = User-7, 64 = User-12
            textEl.subStyle = 64
            textEl.autoplace = false
            // automatically place the text to prevent overlapping with other elements
            textEl.align = Align.RIGHT + Align.VCENTER
            // text alignment horizontally and vertically
            textEl.fontFace = inputFontFace.text
            textEl.fontSize = parseFloat(inputFontSize.text)
            textEl.color = inputTextColor.text
            textEl.offsetX = parseFloat(inputXOffset.text)
            textEl.offsetY = 0
            if (inputReposition.currentIndex != 0) {
                textEl.align = Align.RIGHT + Align.BASELINE
                textEl.offsetY = 0.5
            }
        } else {
            textEl.subStyle = inputStyleGroup.valueAt(inputStyleGroup.currentIndex) + 4
        }
        if (isGrace) {
            textEl.fontSize = textEl.fontSize - 2
        }
    }

    function rgbToHex(rgb) {
        // Convert each component to hexadecimal and concatenate them
        return "#" + ((1 << 24) + (rgb[0] << 16) + (rgb[1] << 8) + rgb[2]).toString(16).slice(1)
    }

    function main() {
        mainShared(processChordInside)
    }

    function processChordInside(cursor, chord, initialKeySig, currKeySig, staff, pitchShift) {
        //     let staff = cursor.element.staff
        //     staff.staffLines = 1
        //     staff.lineDistance = 1.25
        //     staffModified = true
        // staff properties not exposed as api
        // see https://musescore.org/en/node/310685

        let graceChords = chord.graceNotes
        for (let i = 0; i < graceChords.length; i++) {
            transformNotes(graceChords[i], true, initialKeySig, currKeySig, pitchShift)
        }
        transformNotes(chord, false, initialKeySig, currKeySig, pitchShift)
    }

    function transformNotes(chord, isGrace, initialKeySig, currentKeySig, pitchShift) {
        // const invisibleColor = rgbToHex([240,240,240]) // f0f0f0
        // const invisibleColor = "#f3f3f3"
        // const invisibleColor = "#f9f9f9" // 249, page background color
        const notes = chord.notes
        const invisibleColor = inputColor.text
        for (let i = 0; i < notes.length; i++) {
            let note = notes[i]
            let refNote = getRefNote(initialKeySig, currentKeySig)
            let textEl = newElement(Element.FINGERING)
            textEl.text = createNoteTextForPitch(note.pitch + pitchShift, refNote)
            formatText(textEl, isGrace)
            if (["1/2","3/4","7/8","15/16","31/32"].includes(chord.duration.str)) {
                // don't know how to get notehead type, so infer from duration
                // half note with 0,1,2,3,4 dots
                // textEl.frameType = 2 // circle
                // textEl.framePadding = 0.1
                textEl.fontStyle = 2 // italic
            }
            if (!note.visible) {
                textEl.visible = false
            }
            note.add(textEl)
            if (inputHideMethod.currentIndex == 0) {
                // color
                note.color = invisibleColor
                note.z = 1000
                // notehead (white) under the stem (around 1800)
            }
            if (inputHideMethod.currentIndex == 1) {
                // visibility
                note.visible = false
                // if hide notehead, some numbers will collapse together
                // (notes on adjacent staff line and space)
            }
            // note.small = true
            // note.noStem = true

            if (note.accidental) {
                if (inputHideMethod.currentIndex == 0) {
                    note.accidental.color = invisibleColor
                    note.accidental.small = true
                }
                if (inputHideMethod.currentIndex == 1) {
                    note.accidental.visible = false
                }
            }
            if (inputReposition.currentIndex == 1) {
                // top align
                note.fixed = true
                note.fixedLine = 1 + 3*(notes.length - 1 - i)
                // i=0 is lowest note, line 1 is top space
            } else if (inputReposition.currentIndex == 2) {
                // bottom align
                note.fixed = true
                note.fixedLine = 7 - 3*i
                // line 7 is bottom space
            }
            if (inputNoteheadLeft.checked) {
                note.mirrorHead = 1
                // 0 auto, 1 left, 2 right
                // set note head to the left of the stem
                // to prevent octave dots (to the left of notes) overlapping with stems
                // downside is that stems in different directions are not vertically aligned (noteheads are)
                // also notes on adjacent lines and spaces (e.g. seconds) overlap

                // alternative is to set all stems up (so they are to the right of notes)
                // but stem directions differentiate voices
            }
        }
    }
} // end MuseScore