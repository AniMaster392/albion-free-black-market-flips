# Albion Black Market Flipper

A local browser tool for finding manual Albion Online Black Market flips.

It compares item prices from a source market, usually Caerleon Market, against Black Market buy prices and ranks profitable flips by profit, ROI, freshness, quality, and item cost.

## Required

You must run the Albion Data Client while using this tool.

Download and run Albion Data Client, then open Albion Online and browse/scroll the market items you want to scan. The client uploads the live market rows you see in game to Albion Online Data. This app reads those public Albion Online Data prices.

Without Albion Data Client running, prices may be old or missing.

## How To Run

Open this folder in VS Code:

```text
E:\trash\trash\albion-blackmarket-flipper
```

Use the Live Server extension and click:

```text
Go Live
```

Then open:

```text
http://127.0.0.1:5500/index.html
```

You can also double-click `index.html`, but Live Server is better for browser behavior.

## Workflow

1. Start Albion Data Client.
2. Start Albion Online.
3. Go to Caerleon Market.
4. Search or scroll the items you want.
5. Go to the Black Market and scan the same item types.
6. Return to this app.
7. Choose the correct server: West, East, or Europe.
8. Click `Load Live Prices`.

The app shows profitable flips only by default. Turn on `Debug losses` only when checking why items are not profitable.

## Features

- West / Americas, East / Asia, and Europe server support
- T4.0 through T8.4 item scanning
- Official Albion item icons
- Premium and non-premium tax presets
- Freshness filter in minutes, default 30 minutes
- Profit, ROI, quality, max buy price, and search filters
- CSV export
- Local saved player name display

## Notes

This tool does not automate Albion Online gameplay. It does not click, buy, sell, read memory, inject into the game, or control the game client. It is only a manual market calculator using public Albion Online Data prices.

Player name auto-detection is not available in this static HTML version. Type your player name once in the app and it will be saved in your browser.

## Credits

Market data is provided through the Albion Online Data ecosystem and depends on players running Albion Data Client.

Albion Online item icons are loaded from the official Albion render endpoint.
