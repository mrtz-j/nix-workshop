fn main() {
    let message = "Hello from Rust!";
    let width = message.len() + 4;

    // Print the speech bubble
    println!(" {}", "-".repeat(width));
    println!("< {} >", message);
    println!(" {}", "-".repeat(width));

    // Print the cow
    println!("        \\   ^__^");
    println!("         \\  (oo)\\_______");
    println!("            (__)\\       )\\/\\");
    println!("                ||----w |");
    println!("                ||     ||");
}

