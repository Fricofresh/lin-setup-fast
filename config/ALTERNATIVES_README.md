<!-- Created with AI -->

# Update Alternatives Management System
This system provides an easy way to manage `update-alternatives` through a single YAML configuration file and script.

## Files

- **setupAlternatives.sh** - Main script that reads the configuration and sets up alternatives
- **alternatives.yml** - YAML configuration file with a list of alternatives to set up

## How to Use

### 1. Add Alternatives to the Configuration

Edit `alternatives.yml` and add your alternatives in YAML format:

```yaml
alternatives:
  - command: python
    path: /usr/bin/python3
    priority: 30
  - command: editor
    path: /usr/bin/vim
    priority: 20
```

**Parameters:**
- `command`: The name of the command that will be available in `/usr/bin`
- `path`: Full absolute path to the actual program
- `priority`: Priority level (higher number = higher priority when no alternative is explicitly selected)

### 2. Run the Setup Script

```bash
sudo ./setupAlternatives.sh
```

The script will:
- ✓ Read all entries from `alternatives.yml`
- ✓ Check if each program is installed (executable)
- ✓ Skip programs that don't exist
- ✓ Set up alternatives for installed programs
- ✓ Display a summary of what was processed

### 3. Verify the Setup

Check the established alternatives:
```bash
update-alternatives --list command_name
```

Or display all configured alternatives:
```bash
update-alternatives --list
```

## Example Configuration

```yaml
alternatives:
  # Python alternatives
  - command: python
    path: /usr/bin/python3
    priority: 30

  # Editor alternatives
  - command: editor
    path: /usr/bin/nano
    priority: 10
  - command: editor
    path: /usr/bin/vim
    priority: 20
  - command: editor
    path: /usr/bin/emacs
    priority: 15

  # Java alternatives
  - command: java
    path: /usr/lib/jvm/java-17-openjdk-amd64/bin/java
    priority: 17
  - command: java
    path: /usr/lib/jvm/java-11-openjdk-amd64/bin/java
    priority: 11
```

## What the Script Does

1. **Parses alternatives.yml**: Reads the YAML configuration file using `yq`
2. **Validates entries**: Ensures each entry has the required fields (command, path, priority)
3. **Checks program existence**: Only processes alternatives where the program exists and is executable
4. **Sets up alternatives**: Uses `update-alternatives --install` to create or update alternatives
5. **Provides feedback**: Shows colored output indicating success, skipped, or failed entries

## Features

- ✅ **YAML format**: Human-readable configuration format
- ✅ **Program checking**: Automatically skips programs that aren't installed
- ✅ **Idempotent**: Can be run multiple times safely
- ✅ **Clear feedback**: Colored output shows what was processed
- ✅ **Grouped alternatives**: Multiple programs can have the same command name (priority-based selection)
- ✅ **Comments support**: Add comments in YAML format using `#`

## Requirements

- `yq`: YAML query tool (required for parsing the configuration file)
  - The script will automatically offer to install `yq` if it's missing
  - If `nala` is available, you'll have the option to use it or `apt`
  - Manual installation: `sudo apt install yq` or `sudo nala install yq`

## Notes

- The script **must be run with sudo** (requires root privileges)
- Whitespace is automatically trimmed from configuration values
- Comments in YAML use `#` prefixes
- Ensure YAML indentation is correct (use 2 or 4 spaces, not tabs)

