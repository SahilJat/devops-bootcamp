import requests
import sys

def check_website(url):
    print(f"--- Connecting to {url} ---")
    
    try:
        # Send a GET request (Like opening it in Chrome)
        # timeout=5 means "Give up if it takes longer than 5 seconds"
        response = requests.get(url, timeout=5)
        
        # Check the Status Code (The Traffic Light)
        status = response.status_code
        
        if status == 200:
            print(f"✅ ONLINE: Status {status} (OK)")
        elif status == 404:
            print(f"⚠️  WARNING: Status {status} (Page Not Found)")
        elif status >= 500:
            print(f"❌ CRITICAL: Status {status} (Server Error)")
        else:
            print(f"ℹ️  Status: {status}")

    except requests.exceptions.ConnectionError:
        print("❌ CRITICAL: Connection Failed! (DNS Error or Server Down)")
        sys.exit(1)
    except requests.exceptions.Timeout:
        print("❌ CRITICAL: Timed Out! Server is too slow.")
        sys.exit(1)

if __name__ == "__main__":
    # Test 1: A working site
    check_website("https://www.google.com")
    
    print("\n")
    
    # Test 2: A fake site (Should fail)
    check_website("https://www.google.com/this-page-does-not-exist")

