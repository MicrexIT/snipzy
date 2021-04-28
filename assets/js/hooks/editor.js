import ace from "brace";
import "brace/mode/json";
import "brace/mode/elixir";
import "brace/theme/monokai";
import "brace/ext/searchbox";

export default {
  save() {
    this.pushEventTo("#editor", "save", { value: this.editor.getValue() });
  },

  cancel() {
    this.pushEventTo("#editor", "cancel");
  },

  destroyed() {
    this.editor.destroy();
  },

  mounted() {
    // Setup Ace Editor
    const editor_element = this.el.querySelector("#ace-editor");
    this.editor = ace.edit(editor_element);
    this.editor.getSession().setMode("ace/mode/elixir");
    this.editor.setTheme("ace/theme/monokai");
    this.editor.focus();
    console.log('setting up ace editor')

    // Handle `meta+s` to save
    this.editor.commands.addCommand({
      name: "save",
      bindKey: { win: "Ctrl-S", mac: "Command-S" },
      exec: this.save.bind(this),
    });

    // Handle `esc` to cancel editor changes and close editor
    this.editor.commands.addCommand({
      name: "cancel",
      bindKey: { win: "Esc", mac: "Esc" },
      exec: this.cancel.bind(this),
    });
  },
};
