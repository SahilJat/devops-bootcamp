import requests
import sys

def spy_on_user(username):
    url = f"https://api.github.com/users/{username}"
    
    print(f"🕵️‍♂️ Connecting to GitHub API for user: {username}...")
    
    response = requests.get(url)
    
    # Check if user exists
    if response.status_code == 404:
        print("❌ User not found!")
        return
    
    # THE MAGIC: Convert JSON text into a Python Dictionary
    data = response.json()
    
    # Now we can access fields just like a dictionary
    name = data.get("name", "Unknown")
    repos = data.get("public_repos")
    followers = data.get("followers")
    bio = data.get("bio", "No bio")
    
    print("-----------------------------")
    print(f"👤 Name:      {name}")
    print(f"📝 Bio:       {bio}")
    print(f"📦 Repos:     {repos}")
    print(f"⭐ Followers: {followers}")
    print("-----------------------------")

if __name__ == "__main__":
    # Ask for input in the terminal
    target = input("Enter a GitHub username: ")
    spy_on_user(target)
