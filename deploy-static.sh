#!/bin/bash

echo "🚀 Deploying Digital Resume as Static Site..."

# Check if we're in the right directory
if [ ! -f "public/index.html" ]; then
    echo "❌ Error: public/index.html not found. Please run this from the project root."
    exit 1
fi

# Test local server
echo "🧪 Testing local server..."
npm start &
SERVER_PID=$!
sleep 3

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
git commit -m "Deploy static site: $(date)"
git push origin main

echo "🎉 Static deployment complete!"
echo "🌐 Render: Go to Render Dashboard → Create Static Site → Connect GitHub → Publish Directory: ./public"
echo "🌐 Vercel: https://vercel.com/new → Import from GitHub → Deploy"
echo "🌐 Netlify: https://app.netlify.com → New site from Git → Connect GitHub → Deploy"
echo "📱 Local: http://localhost:3000"