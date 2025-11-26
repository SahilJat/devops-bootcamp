import shutil
import sys

def check_disk_usage(path="/"):
    # Get disk stats
    total, used, free = shutil.disk_usage(path)

    # Convert bytes to Gigabytes (GB) for humans
    free_gb = free // (2**30)
    total_gb = total // (2**30)

    print(f"--- Disk Check: {path} ---")
    print(f"Total: {total_gb} GB")
    print(f"Free:  {free_gb} GB")

    # The Logic: Alert if less than 20GB free
    limit_gb = 20
    
    if free_gb < limit_gb:
        print(f"❌ CRITICAL: Low Disk Space! Only {free_gb}GB remaining.")
        sys.exit(1)
    else:
        print(f"✅ Status: Healthy ({free_gb}GB free)")
        sys.exit(0)

if __name__ == "__main__":
    check_disk_usage("/")
