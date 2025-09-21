# 🚀 DTT - The Typing Test

A sleek, terminal-based typing speed test built entirely in Bash. Challenge yourself, improve your WPM, and master the keyboard with this minimalist yet powerful typing tutor.

![License](https://img.shields.io/badge/License-MIT-green?style=for-the-badge)

## Demo

![Demo](demo.gif)

## ✨ Features

- **Real-time Feedback**: See your typing accuracy instantly with color-coded characters
- **Comprehensive Stats**: Track WPM, CPM, accuracy, and more
- **Customizable Tests**: Adjust the number of words to type
- **Error Handling**: Optional "stop on error" mode for focused practice
- **Backspace Support**: Correct mistakes as you go (when enabled)
- **Auto-restart**: Keep practicing without manual restarts
- **Terminal Optimized**: Clean, distraction-free interface

## 🎯 How It Works

DTT displays a random selection of words for you to type. As you type:

- ✅ **Green** = Correct character
- ❌ **Red** = Incorrect character
- 🔵 **Blue** = Current character to type

The script calculates your typing speed and accuracy in real-time, providing detailed statistics upon completion.

## 🚀 Quick Start

1. **Clone the repository**:
   ```bash
   git clone <repository-url>
   cd dtt
   ```

2. **Make the script executable**:
   ```bash
   chmod +x dtt
   ```

3. **Run the typing test**:
   ```bash
   ./dtt
   ```

## ⚙️ Configuration

### Environment Variables

Customize your typing experience with these environment variables:

```bash
# Set number of words (default: 15)
export NUMWORDS=20

# Enable stop-on-error mode (default: 0)
export STOPONERROR=1

# Use custom word list (default: 1000-words.txt)
export WORDSLIST=/path/to/your/words.txt
```

### Word List

DTT automatically finds word lists in this order:

1. **`1000-words.txt`** in the same directory as the script (portable!)
2. **`1000-words.txt`** in the current working directory
3. **System dictionary**: `/usr/share/dict/words` (fallback)

You can also:
- Provide your own word list via the `WORDSLIST` environment variable
- The script comes with a curated `1000-words.txt` file of common English words

## 🎮 Controls

| Key | Action |
|-----|--------|
| **Type** | Enter characters |
| **Backspace** | Delete previous character (when stop-on-error is off) |
| **Ctrl+Z** | Toggle stop-on-error mode |
| **Escape** | Exit and restart |

## 📊 Statistics

After completing each test, DTT displays:

- **WPM**: Words Per Minute (raw)
- **CPM**: Characters Per Minute (raw)
- **WPM accurate**: Words Per Minute (accounting for errors)
- **CPM accurate**: Characters Per Minute (accounting for errors)
- **Accuracy**: Percentage of correct characters
- **Correct chars**: Number of correct characters typed
- **Elapsed time**: Total time taken

## 🏁 Stop-on-Error Mode

Toggle with **Ctrl+Z** during a test:

- **Disabled** (default): You can backspace to correct mistakes
- **Enabled**: Must type each character correctly before proceeding

This mode is perfect for building muscle memory and accuracy!

## 🛠️ Requirements

- **Bash** (tested with Bash 4+)
- **Standard Unix utilities**: `tput`, `shuf`, `grep`, `tr`, `awk`
- **Python 3** (for terminal clearing calculations)
- **Terminal with color support**

## 📝 Example Session

```bash
$ ./dtt

the quick brown fox jumps over lazy dog
[You type here...]

WPM:           45
CPM:           225

WPM accurate:  42
CPM accurate:  210

Accuracy:      93.33%
Correct chars: 14 / 15

Elapsed:       2.000 seconds
```

## 🎯 Tips for Improvement

1. **Start slow**: Focus on accuracy first, speed will follow
2. **Use stop-on-error**: Build perfect typing habits
3. **Practice daily**: Consistency is key to improvement
4. **Monitor progress**: Track your WPM and accuracy over time
5. **Proper posture**: Sit straight and keep wrists neutral

## 🤝 Contributing

Found a bug or have a feature idea? Feel free to:

1. Open an issue
2. Fork the repository
3. Create a feature branch
4. Submit a pull request

## 📄 License

MIT License - feel free to use, modify, and distribute!

---

**Happy typing! 🎹**
