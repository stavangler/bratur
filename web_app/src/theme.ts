import { createMuiTheme } from "@material-ui/core"

export const knowitColors = {
  black: "#333333",
  white: "#F1F0ED",
  forest: "#4B6455",
  pear: "#B7DEBD",
  flamingo: "#FAC0B1",
  mint: "#DBEEDE",
  lollipop: "#FF00FF",
  sand: "#E4E1DB",
  clay: "#A5B1AA",
}

export const theme = createMuiTheme({
  palette: {
    primary: {
      main: knowitColors.pear,
    },
    secondary: {
      main: knowitColors.forest,
    },
    background: {
      default: knowitColors.white,
    },
    common: {
      white: knowitColors.white,
      black: knowitColors.black,
    },
    action: {
      selected: knowitColors.sand,
      disabled: knowitColors.clay,
    },
    text: {
      primary: knowitColors.black,
    },
    type: "light",
  },
  typography: {
    fontFamily: [
      "Arial",
      "Liberation Sans",
      "Frutiger",
      "Frutiger Linotype",
      "Univers",
      "Calibri",
      "Gill Sans",
      "Gill Sans MT",
      "Myriad Pro",
      "Myriad",
      "DejaVu Sans Condensed",
      "Nimbus Sans L",
      "Tahoma",
      "Geneva",
      "Helvetica Neue",
      "Helvetica",
      "sans-serif",
    ].join(","),
    fontSize: 16,
    htmlFontSize: 16,
    button: {
      fontFamily: "Roboto",
    },
  },
})
