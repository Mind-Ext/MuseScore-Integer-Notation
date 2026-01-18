//==============================================
//  Integer Notation & Numbered Notation plugin for MuseScore v4
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
    version: "0.8.2 (465)"
    title: qsTr("Integer Notation Outside")
    menuPath: "Plugins." + qsTr("Integer Notation Outside")
    description: qsTr("Add Integer Notation or Numbered Notation above/below the staves")
    pluginType: "dialog"
    width: 320
    height: 620

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
                text: "Show notes in chords"
                Layout.fillWidth: true
            }
            ComboBox {
                id: inputChordNotesDisplay
                Layout.alignment: Qt.AlignRight
                Layout.preferredWidth: 140
                currentIndex: 0
                model: ["All notes", "Top note only", "Bottom note only"]
            }
        }

        RowLayout {
            Label {
                text: "Placement"
                Layout.fillWidth: true
            }
            ComboBox {
                id: inputPlacement
                model: ["Above", "Below"]
                Layout.alignment: Qt.AlignRight
                Layout.preferredWidth: 100
            }
        }

        RowLayout {
            Label {
                text: "Auto placement (prevent overlap)"
                Layout.fillWidth: true
            }
            CheckBox {
                id: inputAutoPlacement
                text: ""
                checked: true
                Layout.alignment: Qt.AlignRight
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
                text: "10"
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
                text: "Y offset"
                Layout.fillWidth: true
            }
            TextField {
                id: inputYOffset
                text: "0"
                selectByMouse: true
                Layout.preferredWidth: 60
                Layout.alignment: Qt.AlignRight
            }
        }

        RowLayout {
            Label {
                text: "Extra Y offset under chord symbols"
                Layout.fillWidth: true
            }
            TextField {
                id: inputChordSymbolOffset
                text: "3.5"
                selectByMouse: true
                Layout.preferredWidth: 60
                Layout.alignment: Qt.AlignRight
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
                    // quit first, otherwise cmd() won't work in 4.4+
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
        return offsetToClass[(keySig + 12)%12]
    }

    function keySigToNoteNames(keySig) {
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
        return noteNames[(n+1200) % 12]
    }

    function getKeySigText() {
        var cursor = curScore.newCursor()
        if (curScore.selection.elements.length) {
            cursor.rewind(Cursor.SELECTION_START)
        } else {
            cursor.rewind(Cursor.SCORE_START)
        }
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
            keySigText = `(${symbol}×${Math.abs(keySigOffset)}) ${keySigText}`
        }

        var refNote = pitchClass + 60
        if (refNote >= 67) {
            refNote -= 12
        }
        var oct = Math.floor(refNote / 12) - 1
        if (noteNames[0] == "Cb") {
            oct += 1
        }
        inputReferenceNote.value = refNote
        return `${prefix}${keySigText}, ${noteNames[0]}${oct}=${refNote}`
    }

    // Check if segment has a chord symbol (Harmony element)
    function hasChordSymbol(segment, staffIdx) {
        if (!segment || !segment.annotations) return false
        for (let i = 0; i < segment.annotations.length; i++) {
            let annotation = segment.annotations[i]
            if (annotation.type === Element.HARMONY) {
                // Check if the chord symbol belongs to this staff
                if (annotation.staff === staffIdx || segment.annotations.length > 0) {
                    return true
                }
            }
        }
        return false
    }

    function main() {
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
                        let chordSymbolPresent = hasChordSymbol(cursor.segment, staff)
                        
                        let graceChords = cursor.element.graceNotes
                        for (let i = 0; i < graceChords.length; i++) {
                            let textEl = createChordText(graceChords[i], initialKeySig, currKeySig)
                            formatText(textEl, true, graceChords.length - i, chordSymbolPresent)
                            cursor.add(textEl)
                        }
                        let textEl = createChordText(cursor.element, initialKeySig, currKeySig)
                        formatText(textEl, false, 0, chordSymbolPresent)
                        cursor.add(textEl)
                    }   
                    cursor.next()
                }
            }
        }
        if (fullScore) {
            cmd("escape")
        }
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

    function createRefNoteSigText(initialKeySig, currKeySig) {
        let pc1 = keySigToPitchClass(initialKeySig)
        let pc2 = keySigToPitchClass(currKeySig)
        let keyChangeOffset =  inputFollowKeyChange.checked ? (pc2 + 12 - pc1) % 12 : 0
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
        if (inputRefSigFormat.currentIndex == 0)  {
            prefix += inputNotationFormat.currentIndex == 0 ? "0=" : "1="
        } else if (inputRefSigFormat.currentIndex == 1) {
            prefix += inputNotationFormat.currentIndex == 0 ? "9=" : "6="
            keyName = keyNameMinor
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

    function createChordText(chord, initialKeySig, currKeySig) {
        let pc1 = keySigToPitchClass(initialKeySig)
        let pc2 = keySigToPitchClass(currKeySig)
        let offset = inputFollowKeyChange.checked ? (pc2 + 12 - pc1) % 12 : 0 
        if (offset > 6) {
            offset -= 12
        }
        let refNote = inputReferenceNote.value + offset

        let el = newElement(Element.STAFF_TEXT)
        let notes = chord.notes
        let dot = "•"
        let text = ""

        let selectedNotes = notes
        if (notes.length > 0) {
            if (inputChordNotesDisplay.currentIndex === 1) {
                selectedNotes = [notes[notes.length - 1]] // top note
            } else if (inputChordNotesDisplay.currentIndex === 2) {
                selectedNotes = [notes[0]] // bottom note
            }
        }

        let noteTexts = []
        for (let i = 0; i < selectedNotes.length; i++) {
            let note = selectedNotes[i]

            if (note.tieBack == null) {  // skip tied notes
                let relPitchClass = (note.pitch - refNote + 1200) % 12
                let relativeOctave = Math.floor((note.pitch - refNote) / 12)

                let noteText = ""
                if (relativeOctave > 0 && inputOctaveDots.checked)
                    noteText += "<sup>" + dot.repeat(relativeOctave) + "</sup>"
                if (relativeOctave < 0 && inputOctaveDots.checked)
                    noteText += "<sub>" + dot.repeat(-relativeOctave) + "</sub>"
                noteText += getNoteText(relPitchClass)
                noteTexts.push(noteText)
            }
        }

        el.text = noteTexts.join("\n")
        return el
    }

    function formatText(textEl, isGrace, graceOffset, hasChordSym) {
        if (inputStyleGroup.currentIndex == 0) {
            textEl.subStyle = 64  // User-12 in MS 4.4+
            textEl.placement = inputPlacement.currentIndex == 0 ? Placement.ABOVE : Placement.BELOW
            textEl.autoplace = inputAutoPlacement.checked
            textEl.align = Align.RIGHT + Align.BASELINE
            textEl.fontFace = inputFontFace.text
            textEl.fontSize = parseFloat(inputFontSize.text)
            textEl.color = inputTextColor.text
            textEl.offsetX = parseFloat(inputXOffset.text)
            textEl.offsetY = parseFloat(inputYOffset.text)
            
            // If there's a chord symbol and placement is Above, add extra Y offset
            // to position the number below the chord symbol
            if (hasChordSym && inputPlacement.currentIndex == 0) {
                textEl.offsetY += parseFloat(inputChordSymbolOffset.text)
            }
            
            if (isGrace) {
                textEl.fontSize = textEl.fontSize * 0.7
                textEl.offsetX += -1.5 * graceOffset
            }
        } else {
            textEl.subStyle = inputStyleGroup.model.get(inputStyleGroup.currentIndex).value + 4
        }
    }
}