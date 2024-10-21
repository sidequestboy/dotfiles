import {
  map,
  rule,
  writeToProfile,
  ifInputSource,
  ModifierParam,
  simlayer,
  layer,
  duoLayer,
  ifApp,
  withModifier,
  ifVar,
  ifDevice,
} from "karabiner.ts";

// only remap when command is involved
const modifierCombos = [
  "⌘",
  "⌘⇧",
  "⌘⌃",
  "⌘⌃⇧",
  "⌘⌃⌥",
  "⌘⌥",
  "⌘⌥⇧",
  "⌘⌃⌥⇧",
] as ModifierParam[]; // "⇪" | "⌘" | "⌥" | "⌃" | "⇧"

const keymap = modifierCombos
  .map((modifierCombo) => [
    map("'", modifierCombo).to("q", modifierCombo),
    map(",", modifierCombo).to("w", modifierCombo),
    map(".", modifierCombo).to("e", modifierCombo),
    map("p", modifierCombo).to("r", modifierCombo),
    map("y", modifierCombo).to("t", modifierCombo),
    map("f", modifierCombo).to("y", modifierCombo),
    map("g", modifierCombo).to("u", modifierCombo),
    map("c", modifierCombo).to("i", modifierCombo),
    map("r", modifierCombo).to("o", modifierCombo),
    map("l", modifierCombo).to("p", modifierCombo),
    map("/", modifierCombo).to("[", modifierCombo),
    map("=", modifierCombo).to("]", modifierCombo),
    map("\\", modifierCombo).to("\\", modifierCombo),

    map("a", modifierCombo).to("a", modifierCombo),
    map("o", modifierCombo).to("s", modifierCombo),
    map("e", modifierCombo).to("d", modifierCombo),
    map("u", modifierCombo).to("f", modifierCombo),
    map("i", modifierCombo).to("g", modifierCombo),
    map("d", modifierCombo).to("h", modifierCombo),
    map("h", modifierCombo).to("j", modifierCombo),
    map("t", modifierCombo).to("k", modifierCombo),
    map("n", modifierCombo).to("l", modifierCombo),
    map("s", modifierCombo).to(";", modifierCombo),
    map("-", modifierCombo).to("'", modifierCombo),

    map(";", modifierCombo).to("z", modifierCombo),
    map("q", modifierCombo).to("x", modifierCombo),
    map("j", modifierCombo).to("c", modifierCombo),
    map("k", modifierCombo).to("v", modifierCombo),
    map("x", modifierCombo).to("b", modifierCombo),
    map("b", modifierCombo).to("n", modifierCombo),
    map("m", modifierCombo).to("m", modifierCombo),
    map("w", modifierCombo).to(",", modifierCombo),
    map("v", modifierCombo).to(".", modifierCombo),
    map("z", modifierCombo).to("/", modifierCombo),

    map("[", modifierCombo).to("-", modifierCombo),
    map("]", modifierCombo).to("=", modifierCombo),
  ])
  .flat();

writeToProfile("TS Config", [
  rule(
    "Map dvorak keys to qwerty when cmd is held",
    ifInputSource({ language: "en", input_source_id: "Dvorak" })
  ).manipulators(keymap),
  rule("Map caps to control, escape if alone.").manipulators([
    map("caps_lock").to("left_control").toIfAlone("escape"),
  ]),
  rule("Remap MMO mouse keys")
    .manipulators([
      map(1).to("mute"),
      map(2).to("volume_decrement"),
      map(3).to("volume_increment"),
      map(4).to("rewind"),
      map(5).to("play_or_pause"),
      map(6).to("fastforward"),
      map(7).to("display_brightness_decrement"),
      map(8).to("mission_control"),
      map(9).to("display_brightness_increment"),
      // map(0).to(0),
      // map("+").to("+"),
      // map("-").to("-"),
    ])
    .condition(
      ifDevice({
        is_keyboard: true,
        vendor_id: 1241,
        product_id: 64088,
      })
    ),
]);
