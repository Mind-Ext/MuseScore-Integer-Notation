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
    version: "0.9.0 (465)"
    title: qsTr("{{ plugin_title_outside }}")
    menuPath: "Plugins." + qsTr("{{ menu_path_outside }}")
    description: qsTr("{{ plugin_description_outside }}")
    pluginType: "dialog"
    width: 320
    height: 620

    Settings {
        id: settings
        category: "IntegerNotationOutside"
        property alias notationFormat: inputNotationFormat.currentIndex
        // property alias referenceNote: inputReferenceNote.value
        property alias refSigFormat: inputRefSigFormat.currentIndex
        property alias followKeyChange: inputFollowKeyChange.checked
        property alias octaveDots: inputOctaveDots.checked
        property alias chordNotesDisplay: inputChordNotesDisplay.currentIndex
        property alias placement: inputPlacement.currentIndex
        property alias autoPlacement: inputAutoPlacement.checked
        property alias fontSize: inputFontSize.text
        property alias fontFace: inputFontFace.text
        property alias textColor: inputTextColor.text
        property alias xOffset: inputXOffset.text
        property alias yOffset: inputYOffset.text
        property alias chordSymbolOffset: inputChordSymbolOffset.text
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
                text: "{{ chord_notes_display_label }}"
                Layout.fillWidth: true
            }
            ComboBox {
                id: inputChordNotesDisplay
                Layout.alignment: Qt.AlignRight
                Layout.preferredWidth: 140
                currentIndex: 0
                model: ["{{ chord_notes_display_all }}", "{{ chord_notes_display_top }}", "{{ chord_notes_display_bottom }}"]
            }
        }

        RowLayout {
            Label {
                text: "{{ placement_label }}"
                Layout.fillWidth: true
            }
            ComboBox {
                id: inputPlacement
                model: ["{{ placement_option_above }}", "{{ placement_option_below }}"]
                Layout.alignment: Qt.AlignRight
                Layout.preferredWidth: 100
            }
        }

        RowLayout {
            Label {
                text: "{{ auto_placement_label }}"
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
                text: "{{ text_size_label }}"
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
                text: "{{ y_offset_label }}"
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
                text: "{{ chord_symbol_offset_label }}"
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

{{ shared_functions }}

    function main() {
        mainShared(processChordOutside)
    }

    function processChordOutside(cursor, chord, initialKeySig, currKeySig, staff, pitchShift) {
        let chordSymbolPresent = hasChordSymbol(cursor.segment, staff)
        let refNote = getRefNote(initialKeySig, currKeySig)

        let graceChords = chord.graceNotes
        for (let i = 0; i < graceChords.length; i++) {
            let textEl = createChordText(graceChords[i], refNote, pitchShift)
            formatText(textEl, true, graceChords.length - i, chordSymbolPresent)
            cursor.add(textEl)
        }
        let textEl = createChordText(chord, refNote, pitchShift)
        formatText(textEl, false, 0, chordSymbolPresent)
        cursor.add(textEl)
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

    function createChordText(chord, refNote, pitchShift) {
        let el = newElement(Element.STAFF_TEXT)
        let notes = chord.notes

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
                noteTexts.push(createNoteTextForPitch(note.pitch + pitchShift, refNote))
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
} // end MuseScore
