import sys

def analyze_logs(file_path):
    error_count = 0
    
    try:
        print(f"--- Scanning {file_path} ---")
        
        with open(file_path, 'r') as file:
            for line in file:
                if "[ERROR]" in line:
                    error_count += 1
                    print(f"🚨 ALERT: {line.strip()}")
        
        print("--------------------------------")
        
        if error_count > 0:
            print(f"❌ CRITICAL: Found {error_count} errors.")
            sys.exit(1)  # Exit with Failure Code
        else:
            print("✅ System Healthy.")
            sys.exit(0)  # Exit with Success Code

    except FileNotFoundError:
        print("File not found! Did you create server.log?")

if __name__ == "__main__":
    analyze_logs("server.log")
