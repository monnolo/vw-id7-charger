#!/bin/bash

echo "--- VW ID.7 Charger Installer ---"

echo "1. Cleaning up old files..."
rm -f index.html car.webp icon.png vw_logo.jpg manifest.json favicon.jpg

echo "2. Downloading Assets..."

# 1. Download Car Image
wget -O car.webp "https://deals.carwow.co.uk/image?filter%5Bbrand_slug%5D=volkswagen&filter%5Bcolour%5D=Metallic+-+Aquamarine+blue&filter%5Bmodel_review_slug%5D=id7-tourer-2024"

# 2. Download VW Logo (White Background)
# We save it as vw_logo.jpg for the UI
wget -O vw_logo.jpg "https://uploads.vw-mms.de/system/production/images/vwn/030/144/images/6fa5f9117e680d48f54013112746a318e982207d/DB2019AL01949_retina_2400.jpg?1649155356"

# 3. Create the App Icon/Favicon from the exact same file
# We use .jpg extension to be technically accurate (since the source is a JPEG)
cp vw_logo.jpg favicon.jpg

echo "3. Creating App Manifest (manifest.json)..."
cat << 'EOF' > manifest.json
{
  "name": "ID.7 Charger",
  "short_name": "ID.7",
  "start_url": "./index.html",
  "display": "standalone",
  "background_color": "#111318",
  "theme_color": "#0b57d0",
  "icons": [
    {
      "src": "favicon.jpg",
      "sizes": "512x512",
      "type": "image/jpeg"
    }
  ]
}
EOF

echo "4. Creating Material Design index.html..."
cat << 'EOF' > index.html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
    <title>VW ID.7 Charging</title>
    
    <!-- PWA / Favicon Setup -->
    <link rel="manifest" href="manifest.json">
    
    <!-- Using the VW Logo as the Favicon -->
    <link rel="icon" type="image/jpeg" href="favicon.jpg">
    <link rel="apple-touch-icon" href="favicon.jpg">
    
    <meta name="theme-color" content="#0b57d0">
    <meta name="apple-mobile-web-app-capable" content="yes">
    <meta name="apple-mobile-web-app-status-bar-style" content="black-translucent">

    <!-- Fonts & Icons -->
    <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@400;500;700&display=swap" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Rounded:opsz,wght,FILL,GRAD@24,400,0,0" rel="stylesheet" />
    <script src="https://cdn.tailwindcss.com"></script>

    <script>
        tailwind.config = {
            darkMode: 'class',
            theme: {
                extend: {
                    fontFamily: { sans: ['Roboto', 'sans-serif'] },
                    colors: {
                        'md-sys-light-surface': '#f9f9fc',
                        'md-sys-light-surface-container': '#eceef4',
                        'md-sys-light-on-surface': '#191c20',
                        'md-sys-light-primary': '#0b57d0',
                        'md-sys-light-on-primary': '#ffffff',
                        'md-sys-light-primary-container': '#d3e3fd',
                        'md-sys-light-on-primary-container': '#041e49',
                        
                        'md-sys-dark-surface': '#111318',
                        'md-sys-dark-surface-container': '#1e2228', 
                        'md-sys-dark-on-surface': '#e2e2e6',
                        'md-sys-dark-primary': '#a8c7fa',
                        'md-sys-dark-on-primary': '#002f65',
                        'md-sys-dark-primary-container': '#0842a0',
                        'md-sys-dark-on-primary-container': '#d3e3fd',
                    }
                }
            }
        }
    </script>
    <script>
        if (localStorage.theme === 'dark' || (!('theme' in localStorage) && window.matchMedia('(prefers-color-scheme: dark)').matches)) {
            document.documentElement.classList.add('dark')
        } else {
            document.documentElement.classList.remove('dark')
        }
    </script>

    <style>
        body { font-family: 'Roboto', sans-serif; }
        input[type=range] { -webkit-appearance: none; background: transparent; height: 24px; }
        input[type=range]::-webkit-slider-runnable-track { width: 100%; height: 16px; cursor: pointer; background: transparent; border-radius: 999px; }
        input[type=range]::-webkit-slider-thumb { -webkit-appearance: none; height: 24px; width: 8px; border-radius: 4px; background: #0b57d0; cursor: grab; margin-top: -4px; box-shadow: 0 2px 6px rgba(0,0,0,0.2); transition: transform 0.1s ease; }
        input[type=range]:active::-webkit-slider-thumb { transform: scaleX(1.5); }
        html.dark input[type=range]::-webkit-slider-thumb { background: #a8c7fa; }
        input[type="time"]::-webkit-calendar-picker-indicator { display: none; }
        .material-card { transition: transform 0.3s cubic-bezier(0.2, 0.0, 0, 1.0), background-color 0.3s; }
        .battery-fill { transition: width 0.5s cubic-bezier(0.2, 0, 0, 1); }
    </style>
</head>
<body class="bg-md-sys-light-surface dark:bg-md-sys-dark-surface text-md-sys-light-on-surface dark:text-md-sys-dark-on-surface min-h-screen flex flex-col items-center p-4 selection:bg-blue-200 dark:selection:bg-blue-800 transition-colors duration-300">

    <div class="w-full max-w-md flex flex-col gap-4 pb-10">
        <div class="flex items-center justify-between py-2 px-2">
            <div class="flex items-center gap-3">
                <div class="w-10 h-10 bg-white rounded-full flex items-center justify-center shadow-sm overflow-hidden">
                     <img src="vw_logo.jpg" class="w-full h-full object-cover">
                </div>
                <h1 class="text-2xl font-normal tracking-normal">ID.7 Tourer</h1>
            </div>
            <button id="themeToggle" class="w-10 h-10 rounded-full flex items-center justify-center hover:bg-black/5 dark:hover:bg-white/10 transition-colors">
                <span class="material-symbols-rounded dark:hidden">dark_mode</span>
                <span class="material-symbols-rounded hidden dark:inline">light_mode</span>
            </button>
        </div>

        <div class="material-card relative w-full h-56 rounded-[28px] overflow-hidden bg-md-sys-light-surface-container dark:bg-md-sys-dark-surface-container shadow-sm">
             <img src="car.webp" class="w-full h-full object-cover object-center opacity-90 dark:opacity-80">
             <div class="absolute inset-0 bg-gradient-to-t from-black/60 to-transparent"></div>
             <div class="absolute bottom-5 left-6 text-white">
                 <p class="text-sm font-medium opacity-80 tracking-wider uppercase">Pro 77 kWh</p>
                 <p class="text-3xl font-normal mt-0.5" id="heroTime">Calculating...</p>
             </div>
        </div>

        <div class="grid grid-cols-2 gap-3">
            <div class="relative bg-md-sys-light-surface-container dark:bg-md-sys-dark-surface-container rounded-t-2xl px-4 pt-6 pb-2 border-b border-black/40 dark:border-white/40 hover:bg-black/5 dark:hover:bg-white/5 transition-colors">
                <label class="absolute top-2 left-4 text-xs text-md-sys-light-primary dark:text-md-sys-dark-primary font-medium">Power (kW)</label>
                <input type="number" id="chargerPower" value="11" inputmode="decimal" class="w-full bg-transparent outline-none text-xl font-normal text-md-sys-light-on-surface dark:text-md-sys-dark-on-surface placeholder-gray-400">
                <span class="material-symbols-rounded absolute right-4 top-4 text-gray-400 pointer-events-none">bolt</span>
            </div>
            <div class="relative bg-md-sys-light-surface-container dark:bg-md-sys-dark-surface-container rounded-t-2xl px-4 pt-6 pb-2 border-b border-black/40 dark:border-white/40 hover:bg-black/5 dark:hover:bg-white/5 transition-colors">
                <label class="absolute top-2 left-4 text-xs text-md-sys-light-primary dark:text-md-sys-dark-primary font-medium">Start Time</label>
                <input type="time" id="startTime" class="w-full bg-transparent outline-none text-xl font-normal text-md-sys-light-on-surface dark:text-md-sys-dark-on-surface text-left">
                <span class="material-symbols-rounded absolute right-4 top-4 text-gray-400 pointer-events-none">schedule</span>
            </div>
        </div>

        <div id="acLimitWarning" class="hidden bg-amber-100 dark:bg-amber-900/30 text-amber-800 dark:text-amber-200 px-4 py-2 rounded-xl text-sm font-medium flex items-center gap-2">
            <span class="material-symbols-rounded text-lg">warning</span>
            <span>AC Limited to 11 kW</span>
        </div>

        <div class="bg-md-sys-light-surface-container dark:bg-md-sys-dark-surface-container rounded-[28px] p-6 flex flex-col gap-8">
            <div class="relative">
                <div class="flex justify-between mb-2">
                    <label class="text-sm font-medium opacity-70">Start Level</label>
                    <span class="text-sm font-bold text-md-sys-light-primary dark:text-md-sys-dark-primary" id="startVal">10%</span>
                </div>
                <div class="relative h-4 bg-black/10 dark:bg-white/10 rounded-full overflow-hidden">
                     <div id="trackStart" class="absolute top-0 left-0 h-full bg-md-sys-light-primary dark:bg-md-sys-dark-primary opacity-30 w-[10%]"></div>
                </div>
                <input type="range" id="startSoC" min="0" max="100" value="10" class="absolute top-0 left-0 w-full opacity-100 z-10 mt-6"> 
            </div>
            <div class="relative mt-2">
                 <div class="flex justify-between mb-2">
                    <label class="text-sm font-medium opacity-70">Target Level</label>
                    <span class="text-sm font-bold text-md-sys-light-primary dark:text-md-sys-dark-primary" id="targetVal">80%</span>
                </div>
                <div class="relative h-4 bg-black/10 dark:bg-white/10 rounded-full overflow-hidden">
                     <div id="trackTarget" class="absolute top-0 left-0 h-full bg-md-sys-light-primary dark:bg-md-sys-dark-primary w-[80%]"></div>
                </div>
                <input type="range" id="targetSoC" min="0" max="100" value="80" class="absolute top-0 left-0 w-full opacity-100 z-10 mt-6">
            </div>
        </div>

        <div class="h-14 bg-md-sys-light-surface-container dark:bg-md-sys-dark-surface-container rounded-2xl overflow-hidden relative flex items-center px-1 border border-black/5 dark:border-white/5">
             <div class="w-full h-8 bg-black/5 dark:bg-white/5 rounded-lg relative overflow-hidden mx-2">
                <div id="barExisting" class="battery-fill h-full bg-md-sys-light-on-surface dark:bg-md-sys-dark-on-surface opacity-30 absolute left-0 top-0"></div>
                <div id="barAdded" class="battery-fill h-full bg-green-500 dark:bg-green-400 absolute top-0"></div>
                <div class="absolute inset-0 flex justify-between px-[10%] pointer-events-none opacity-20">
                   <div class="w-[1px] h-full bg-black dark:bg-white"></div><div class="w-[1px] h-full bg-black dark:bg-white"></div><div class="w-[1px] h-full bg-black dark:bg-white"></div>
                   <div class="w-[1px] h-full bg-black dark:bg-white"></div><div class="w-[1px] h-full bg-black dark:bg-white"></div><div class="w-[1px] h-full bg-black dark:bg-white"></div>
                   <div class="w-[1px] h-full bg-black dark:bg-white"></div><div class="w-[1px] h-full bg-black dark:bg-white"></div><div class="w-[1px] h-full bg-black dark:bg-white"></div>
                </div>
             </div>
             <span class="material-symbols-rounded absolute right-4 text-green-600 dark:text-green-400 animate-pulse">bolt</span>
        </div>

        <div class="grid grid-cols-2 gap-3">
            <div class="bg-md-sys-light-primary-container dark:bg-md-sys-dark-primary-container text-md-sys-light-on-primary-container dark:text-md-sys-dark-on-primary-container p-5 rounded-[24px]">
                <div class="flex items-center gap-2 mb-1 opacity-70">
                    <span class="material-symbols-rounded text-lg">check_circle</span>
                    <span class="text-xs font-bold uppercase tracking-wide">Finish</span>
                </div>
                <p id="finishTime" class="text-3xl font-medium">--:--</p>
                <p id="dayIndicator" class="text-xs font-medium opacity-80 mt-1 hidden">+1 Day</p>
            </div>
            <div class="bg-md-sys-light-surface-container dark:bg-md-sys-dark-surface-container p-5 rounded-[24px] flex flex-col justify-center gap-2">
                <div class="flex justify-between items-center border-b border-black/10 dark:border-white/10 pb-2">
                    <span class="text-xs opacity-70 font-medium">ADDED</span>
                    <span id="resultEnergy" class="text-sm font-bold">-- kWh</span>
                </div>
                <div class="flex justify-between items-center pt-1">
                    <span class="text-xs opacity-70 font-medium">SPEED</span>
                    <span id="avgSpeed" class="text-sm font-bold">-- kW</span>
                </div>
            </div>
        </div>
    </div>

    <script>
        const USABLE_CAPACITY_KWH = 77;
        const MAX_AC_POWER = 11;
        const DC_CURVE = [{soc:0,kw:140},{soc:5,kw:175},{soc:10,kw:175},{soc:20,kw:175},{soc:25,kw:170},{soc:30,kw:150},{soc:40,kw:125},{soc:50,kw:105},{soc:60,kw:90},{soc:70,kw:80},{soc:80,kw:65},{soc:85,kw:50},{soc:90,kw:40},{soc:95,kw:28},{soc:100,kw:0}];
        const els = { power: document.getElementById('chargerPower'), time: document.getElementById('startTime'), sSoc: document.getElementById('startSoC'), tSoc: document.getElementById('targetSoC'), sVal: document.getElementById('startVal'), tVal: document.getElementById('targetVal'), heroT: document.getElementById('heroTime'), finT: document.getElementById('finishTime'), dayInd: document.getElementById('dayIndicator'), en: document.getElementById('resultEnergy'), spd: document.getElementById('avgSpeed'), warn: document.getElementById('acLimitWarning'), barE: document.getElementById('barExisting'), barA: document.getElementById('barAdded'), trackS: document.getElementById('trackStart'), trackT: document.getElementById('trackTarget'), theme: document.getElementById('themeToggle') };
        const now = new Date();
        els.time.value = `${String(now.getHours()).padStart(2,'0')}:${String(now.getMinutes()).padStart(2,'0')}`;
        els.theme.addEventListener('click', () => { const isDark = document.documentElement.classList.toggle('dark'); localStorage.setItem('theme', isDark ? 'dark' : 'light'); });
        function getPower(soc, limit) { let idx = DC_CURVE.findIndex(p => p.soc >= soc); if (idx === -1) return 0; if (idx === 0) return Math.min(limit, DC_CURVE[0].kw); let p1 = DC_CURVE[idx - 1], p2 = DC_CURVE[idx]; let r = (soc - p1.soc) / (p2.soc - p1.soc); return Math.min(limit, p1.kw + (p2.kw - p1.kw) * r); }
        function calc() {
            let start = parseInt(els.sSoc.value); let target = parseInt(els.tSoc.value); let power = parseFloat(els.power.value) || 11;
            if (target < start) { target = start; els.tSoc.value = start; }
            els.sVal.innerText = start + '%'; els.tVal.innerText = target + '%'; els.trackS.style.width = start + '%'; els.trackT.style.width = target + '%';
            els.barE.style.width = start + '%'; els.barA.style.left = start + '%'; els.barA.style.width = (target - start) + '%';
            let isAC = power <= 22; let effPower = power;
            if (isAC) { if (power > MAX_AC_POWER) { effPower = MAX_AC_POWER; els.warn.classList.remove('hidden'); } else { els.warn.classList.add('hidden'); } } else { els.warn.classList.add('hidden'); }
            if (start === target) { els.heroT.innerText = "Complete"; els.finT.innerText = els.time.value; els.dayInd.classList.add('hidden'); els.en.innerText = "0 kWh"; els.spd.innerText = "0 kW"; return; }
            let tHours = 0, tEnergy = 0;
            for (let s = start; s < target; s++) { let eStep = USABLE_CAPACITY_KWH * 0.01; let pStep = isAC ? effPower : getPower(s, effPower); if (pStep < 1) pStep = 1; tHours += eStep / pStep; tEnergy += eStep; }
            let h = Math.floor(tHours); let m = Math.round((tHours - h) * 60); if (m === 60) { h++; m = 0; }
            let durStr = ""; if (h > 0) durStr += `${h} hr `; durStr += `${m} min`; els.heroT.innerText = durStr;
            els.en.innerText = `+${tEnergy.toFixed(1)} kWh`; els.spd.innerText = `${(tEnergy/tHours).toFixed(1)} kW`;
            if (els.time.value) { const [sh, sm] = els.time.value.split(':').map(Number); let end = new Date(); end.setHours(sh, sm, 0, 0); end = new Date(end.getTime() + (tHours * 3600000)); els.finT.innerText = `${String(end.getHours()).padStart(2,'0')}:${String(end.getMinutes()).padStart(2,'0')}`; let startD = new Date(); startD.setHours(sh, sm, 0, 0); if (end.getDate() !== startD.getDate()) els.dayInd.classList.remove('hidden'); else els.dayInd.classList.add('hidden'); }
        }
        ['input', 'change'].forEach(e => { els.sSoc.addEventListener(e, calc); els.tSoc.addEventListener(e, calc); });
        els.power.addEventListener('input', calc); els.time.addEventListener('input', calc);
        calc();
    </script>
</body>
</html>
EOF
echo "Done! Setup complete."
