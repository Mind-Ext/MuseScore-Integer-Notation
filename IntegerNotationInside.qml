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
    version: "0.8.1 (465)"
    title: qsTr("{{ plugin_title }}")
    menuPath: "Plugins." + qsTr("{{ menu_path }}")
    description: qsTr("{{ plugin_description }}")
    pluginType: "dialog"
    width: 320  // menu window size
    height: 600

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
                text: "{{ notation_format_label }}"
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
                text: "{{ reference_note_label }}"
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
                text: "{{ reference_note_signature_label }}"
                Layout.fillWidth: true
            }
            ComboBox {
                id: inputRefSigFormat
                Layout.alignment: Qt.AlignRight
                Layout.preferredWidth: 100
                currentIndex: 0
                model: ListModel {
                    ListElement {
                        text: "{{ signature_option_1st_degree }}"
                    }
                    ListElement {
                        text: "{{ signature_option_6th_degree }}"
                    }
                    ListElement {
                        text: "{{ signature_option_none }}"
                    }
                }
            }
        }
        RowLayout {
            Label {
                text: "{{ reference_note_follows_key_change_label }}"
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
                text: "{{ show_octave_dots_label }}"
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
                text: "{{ set_notehead_left_label }}"
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
                text: "{{ reposition_notes_vertically_label }}"
                Layout.fillWidth: true
            }
            ComboBox {
                id: inputReposition
                model: ["{{ reposition_option_none }}", "{{ reposition_option_top_align }}", "{{ reposition_option_bottom_align }}"]
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
                text: "{{ text_size_label }}"
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
                text: "{{ text_font_label }}"
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
                text: "{{ text_color_label }}"
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
                text: "{{ x_offset_label }}"
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
                text: "{{ hide_notehead_method_label }}"
                Layout.fillWidth: true
            }
            ComboBox {
                currentIndex: 0
                id: inputHideMethod
                model: ListModel {
                    property var key
                    ListElement {
                        text: "{{ hide_method_color }}"
                    }
                    ListElement {
                        text: "{{ hide_method_visibility }}"
                    }
                }
                Layout.preferredWidth: 100
                Layout.alignment: Qt.AlignRight
            }
        }

        RowLayout {
            Label {
                text: "{{ notehead_color_label }}"
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
                text: "{{ text_style_label }}"
                Layout.fillWidth: true
            }
            ComboBox {
                id: inputStyleGroup
                currentIndex: 0
                textRole: "text"
                model: ListModel {
                    ListElement {
                        text: "{{ text_style_custom }}"
                        value: -1
                    }
                    ListElement {
                        text: "{{ text_style_user_1 }}"
                        value: 49
                    }
                    ListElement {
                        text: "{{ text_style_user_2 }}"
                        value: 50
                    }
                    ListElement {
                        text: "{{ text_style_user_3 }}"
                        value: 51
                    }
                    ListElement {
                        text: "{{ text_style_user_4 }}"
                        value: 52
                    }
                    ListElement {
                        text: "{{ text_style_user_5 }}"
                        value: 53
                    }
                    ListElement {
                        text: "{{ text_style_user_6 }}"
                        value: 54
                    }
                    ListElement {
                        text: "{{ text_style_user_7 }}"
                        value: 55
                    }
                    ListElement {
                        text: "{{ text_style_user_8 }}"
                        value: 56
                    }
                    ListElement {
                        text: "{{ text_style_user_9 }}"
                        value: 57
                    }
                    ListElement {
                        text: "{{ text_style_user_10 }}"
                        value: 58
                    }
                    ListElement {
                        text: "{{ text_style_user_11 }}"
                        value: 59
                    }
                    ListElement {
                        text: "{{ text_style_user_12 }}"
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
                text: "{{ cancel_button_label }}"
                onClicked: {
                    quit()
                }
            }
            Button {
                Layout.alignment: Qt.AlignRight
                Layout.preferredWidth: 80
                text: "{{ ok_button_label }}"
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
        return offsetToClass[(keySig + 12)%12]
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
        return noteNames[(n+1200) % 12]
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
        let log = ""

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
                                // add key signature text
                                if (inputFollowKeyChange.checked || prevKeySig === undefined) {
                                    cursor.add(createRefNoteSigText(initialKeySig, currKeySig))
                                }
                            }
                            prevKeySig = currKeySig
                        }
                    }
                    if (cursor.element && cursor.element.type == Element.CHORD) {
                        //     let staff = cursor.element.staff
                        //     staff.staffLines = 1
                        //     staff.lineDistance = 1.25
                        //     staffModified = true
                        // staff properties not exposed as api
                        // see https://musescore.org/en/node/310685
                        
                        let graceChords = cursor.element.graceNotes
                        for (let i = 0; i < graceChords.length; i++) {
                            transformNotes(graceChords[i], true, initialKeySig, currKeySig)
                        }
                        transformNotes(cursor.element, false, initialKeySig, currKeySig)
                    }   
                    cursor.next()
                } // end while
            } // end for voice
        } // end for staff
        if (log) {
            const el = newElement(Element.SYSTEM_TEXT)
            el.text = log
            cursor.rewind(Cursor.SELECTION_START)
            cursor.add(el)
        }
        if (fullScore) {
            cmd("escape")
        }
    } // end function

    function transformNotes(chord, isGrace, initialKeySig, currentKeySig) {
        // const invisibleColor = rgbToHex([240,240,240]) // f0f0f0
        // const invisibleColor = "#f3f3f3"
        // const invisibleColor = "#f9f9f9" // 249, page background color
        const notes = chord.notes
        const invisibleColor = inputColor.text
        for (let i = 0; i < notes.length; i++) {
            let note = notes[i]
            let textEl = createTextElement(note, initialKeySig, currentKeySig)
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

    function createTextElement(note, initialKeySig, currKeySig) {
        let pc1 = keySigToPitchClass(initialKeySig)
        let pc2 = keySigToPitchClass(currKeySig)
        let offset = (pc2 + 12 - pc1) % 12
        if (offset > 6) {
            offset -= 12
        }
        let refNote = inputReferenceNote.value + offset

        let el = newElement(Element.FINGERING)

        let relPitchClass = (note.pitch - refNote + 1200) % 12
        let relativeOctave = Math.floor((note.pitch - refNote) / 12)
        let dot = "•"
        let text = ""
        if (relativeOctave > 0 && inputOctaveDots.checked)
            text += "<sup>" + dot.repeat(relativeOctave) + "</sup>"
        if (relativeOctave < 0 && inputOctaveDots.checked)
            text += "<sub>" + dot.repeat(-relativeOctave) + "</sub>"
        text += getNoteText(relPitchClass)
        el.text = text
        return el
    } // end for note
} // end MuseScore
