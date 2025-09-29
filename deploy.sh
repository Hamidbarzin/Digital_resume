#!/bin/bash

echo "🚀 Deploying Digital Resume..."

# Check if we're in the right directory
if [ ! -f "package.json" ]; then
    echo "❌ Error: package.json not found. Please run this from the project root."
    exit 1
fi

# Install dependencies
echo "📦 Installing dependencies..."
npm install

# Test the server locally
echo "🧪 Testing server locally..."
npm start &
SERVER_PID=$!
sleep 5

# Check if server is running
if curl -f http://localhost:3000/health > /dev/null 2>&1; then
    echo "✅ Server is running successfully!"
    kill $SERVER_PID
else
    echo "❌ Server test failed!"
    kill $SERVER_PID
    exit 1
fi

# Push to GitHub
echo "📤 Pushing to GitHub..."
git add .
git commit -m "Deploy: $(date)"
git push origin main

echo "🎉 Deployment complete!"
echo "🌐 Render URL: https://digital-resume-1o83.onrender.com"
echo "🌐 Vercel URL: https://digital-resume-vercel.vercel.app"
echo "🌐 Netlify URL: https://digital-resume-netlify.netlify.app"
echo "🌐 GitHub Pages: https://hamidbarzin.github.io/Digital_resume"
echo "📱 Local URL: http://localhost:3000"
