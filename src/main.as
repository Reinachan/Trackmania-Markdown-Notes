[Setting name="Show Modal?"]
bool showModal = true;

const string savedNoteName = "SavedNote.md";
const string savedNote = IO::FromStorageFolder(savedNoteName);

bool showInput = false;
string sampleText = "# Custom Notes!\n\nThis is a sample note. You're able to put anything you want here though. Markdown **formatting** is supported too!\n\nThis window is resizable";
string text = sampleText;

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

void RenderInterface() {
  if (!showModal) {
    return;
  }

  
  UI::Begin("Notes", UI::WindowFlags::NoTitleBar);
    UI::BeginGroup();
      if (UI::Button(Icons::FileO)) {
        showInput = false;
      }
      if (UI::Button(Icons::Pencil)) {
        showInput = true;
      }
    UI::EndGroup();
    UI::SameLine();


    if (!showInput) {
    UI::BeginGroup();
      UI::Markdown(text);

    UI::EndGroup();
    }

    if (showInput) {
      UI::BeginGroup();
        UI::Text("Markdown formatting supported");
        
        text = UI::InputTextMultiline("", text, UI::GetContentRegionAvail().opSub(vec2(0,30)), UI::InputTextFlags::AllowTabInput);

          if(UI::Button("Save")) {
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
