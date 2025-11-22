# GigaShield

GigaShield is a visual firewall dashboard designed to simplify the management of iptables rules through an intuitive drag-and-drop interface. It provides a modern, web-based UI for creating, organizing, and visualizing firewall policies without directly modifying system configurations. This tool serves as a layer above the traditional iptables command-line interface, making it easier for users to understand and manipulate network filtering rules.

## Features

- **Visual Rule Management**: Drag and drop rules between INPUT, OUTPUT, and FORWARD chains to organize your firewall policy.
- **Rule Creation**: Add new rules via a modal interface, specifying chain, action (ACCEPT/DROP/REJECT), protocol (TCP/UDP/ICMP/ALL), port, source/destination IPs, and optional notes.
- **Command Generation**: Generate iptables command previews for easy integration into scripts or direct application.
- **Import Functionality**: Parse and import existing iptables rules from the output of `sudo iptables -L -n -v --line-numbers`.
- **Real-time Visualization**: View charts showing allowed/blocked ports and rule distribution across chains.
- **Summary Dashboard**: Monitor total rules, active chains, and action counts (ACCEPT vs DROP/REJECT).
- **Table Support**: Switch between iptables tables (filter, nat, mangle, raw) - currently optimized for the filter table.
- **Responsive Design**: Dark-themed, mobile-friendly interface with smooth animations.
- **Sample Rules**: Includes pre-loaded sample rules for quick testing and learning.

## How to Use

1. **Open the Application**: Simply open `index.html` in any modern web browser. No server or installation required.
2. **Add Rules**: Click the "+ Nova regra" button or the floating action button to create new firewall rules. Fill in the details and save.
3. **Organize Rules**: Drag rule cards between the INPUT, OUTPUT, and FORWARD lanes to adjust their chain assignment and order.
4. **Visualize Data**: Check the charts for port statistics and chain distribution.
5. **Generate Commands**: Click "Gerar comandos iptables" to preview the iptables commands based on your rules.
6. **Import Existing Rules**: Paste the output of `sudo iptables -L -n -v --line-numbers` into the import textarea and click "Transformar em visual" to load existing configurations.
7. **Export for Use**: Copy the generated commands to apply to your system or integrate into automation scripts.

Note: This is a client-side preview tool. It does not directly modify your system's iptables rules. Use the generated commands responsibly on your server.

## Installation

No installation is required. GigaShield is a static web application consisting of a single HTML file with embedded CSS and JavaScript.

- Download or clone the repository.
- Open `index.html` in your web browser.
- Start managing your firewall rules visually!

For production use, consider integrating this UI with a backend parser (e.g., PHP/Python) to handle `iptables-save` output for more robust rule parsing.

## Credits

Created by **Osvaldo Janeri Filho** (osvaldo@perito.digital)

- Website: [perito.digital](https://perito.digital)
- LinkedIn: [linkedin.com/in/ojaneri](https://linkedin.com/in/ojaneri)
- Email: [osvaldo@perito.digital](mailto:osvaldo@perito.digital)

## Project Link

[https://github.com/ojaneri/gigashield](https://github.com/ojaneri/gigashield)
