[Setting name="Show Modal?"]
bool showModal = true;

const string savedNoteName = "SavedNote.md";
const string savedNote = IO::FromStorageFolder(savedNoteName);

bool showInput = false;
string sampleText = "# Custom Notes!\n\nThis is a sample note. You're able to put anything you want here though. Markdown **formatting** is supported too!\n\nThis window is resizable";
string text = sampleText;

// Deletes the saved note
// TODO: Make this delete specific note when multiple notes implemented
void DeleteFiles() {
  IO::Delete(savedNote);
  text = sampleText;
}

void Main() {
  if (IO::FileExists(savedNote)) {
    text = IO::File(savedNote, IO::FileMode::Read)
            .ReadToEnd();
  }


  print("TMNotes initialised");
}

void RenderMenu() {
  // Adds a "Plugins" menu item for easily hiding and unhiding the plugin
  if (UI::MenuItem(Icons::FileO + " Markdown Notes", selected: showModal)) {
    showModal = !showModal;
  }
}

void Render() {
  // Don't render the modal if the user configged it to be hidden
  if (!showModal) {
    return;
  }
  
  UI::Begin("Notes", UI::WindowFlags::NoTitleBar + UI::WindowFlags::NoCollapse);
    
    // Creates the sidebar nav
    UI::BeginGroup();
      if (UI::Button(Icons::FileO)) {
        showInput = false;
      }
      if (UI::Button(Icons::Pencil)) {
        showInput = true;
      }
    UI::EndGroup();

    UI::SameLine();

    // Renders the markdown when markdown tab is selected
    if (!showInput) {
      UI::BeginGroup();
        UI::Markdown(text);

      UI::EndGroup();
    }

    // Renders the editing tools when the edit tab is selected
    if (showInput) {
      UI::BeginGroup();
        // Input that spans all available space
        text = UI::InputTextMultiline("", text, UI::GetContentRegionAvail().opSub(vec2(0,30)), UI::InputTextFlags::AllowTabInput);

        // Save and clear buttons rendered on the same line
        if(UI::Button("Save")) {
          // Saves note to disk
          // TODO: Add note name and let user save multiple notes
          IO::File(savedNote, IO::FileMode::Write)
            .Write(text);
        }
        UI::SameLine();
        if(UI::Button("Clear")) {
          DeleteFiles();
        }
      UI::EndGroup();
    }

  UI::End();
}
