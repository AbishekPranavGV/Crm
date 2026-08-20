@echo off
setlocal
set "ROOT=%~dp0CRM_AI_Product_Intelligence"
if not exist "%ROOT%" mkdir "%ROOT%"

powershell -NoProfile -ExecutionPolicy Bypass -Command ^
  "$p='%ROOT%'; $files=@{}; ^
  $files['README.txt']=@'"
CRM AI PRODUCT INTELLIGENCE - APPS SCRIPT STARTER

1. Open Google Apps Script and create a new project.
2. Copy Code.gs and Index.html into the project.
3. Deploy > New deployment > Web app.
4. For the first UI review, simply open preview.html in a browser.
5. This starter is a UI/prototype architecture. Gmail/Drive/NLP extraction is intentionally stubbed until your exact company fields/API choices are confirmed.

Architecture:
Gmail -> source email/attachment -> extraction -> validation -> product candidate -> human approval -> Product Master -> price association -> dashboard.

Core rule: AI never directly overwrites the Product Master. It creates a candidate with confidence and source traceability for review.
'@; ^
  $files['appsscript.json']=@'
{
  "timeZone": "Asia/Kolkata",
  "dependencies": {},
  "exceptionLogging": "STACKDRIVER",
  "runtimeVersion": "V8",
  "webapp": {
    "executeAs": "USER_DEPLOYING",
    "access": "ANYONE"
  }
}
'@; ^
  $files['Code.gs']=@'
function doGet() {
  return HtmlService.createTemplateFromFile('Index')
    .evaluate()
    .setTitle('AI Product Intelligence CRM')
    .setXFrameOptionsMode(HtmlService.XFrameOptionsMode.ALLOWALL);
}

function include(filename) {
  return HtmlService.createHtmlOutputFromFile(filename).getContent();
}

// Prototype data service. Replace with SpreadsheetApp/GmailApp/DriveApp logic.
function getDashboardData() {
  return {
    kpis: { candidates: 18, review: 6, products: 428, matched: 91 },
    candidates: [
      {id:'PC-1042', name:'Digital Multimeter DM-9208', model:'DM-9208', source:'Gmail • Quote_2026_08.pdf', confidence:96, price:'₹2,450', status:'Review'},
      {id:'PC-1043', name:'Clamp Meter CM-3286', model:'CM-3286', source:'Gmail • Price_List_Aug.pdf', confidence:88, price:'₹4,900', status:'Review'},
      {id:'PC-1044', name:'Insulation Tester IT-500', model:'IT-500', source:'Gmail • Supplier_Offer.pdf', confidence:72, price:'₹8,750', status:'Needs review'}
    ]
  };
}

function testExtraction() {
  return {ok:true, message:'Extraction pipeline test passed. Connect Gmail/Drive/NLP after confirming fields.'};
}

function approveCandidate(candidate) {
  // TODO: write approved product into Product Master Sheet.
  return {ok:true, message:'Candidate approved (prototype).', id:candidate && candidate.id};
}

function rejectCandidate(candidate) {
  return {ok:true, message:'Candidate rejected (prototype).', id:candidate && candidate.id};
}
'@; ^
  $files['Index.html']=@'
<!doctype html>
<html>
<head>
  <base target="_top">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <style>
    :root{--bg:#f5f7fb;--card:#fff;--ink:#172033;--muted:#6b7280;--line:#e7eaf0;--accent:#4f46e5;--good:#15803d;--warn:#b45309;--danger:#b91c1c;}
    *{box-sizing:border-box} body{margin:0;background:var(--bg);font-family:Inter,Segoe UI,Arial,sans-serif;color:var(--ink)}
    .app{display:flex;min-height:100vh}.side{width:250px;background:#111827;color:#dbe3ef;padding:22px 14px;position:fixed;inset:0 auto 0 0}.brand{font-size:19px;font-weight:800;padding:8px 12px 24px;color:white}.brand small{display:block;color:#94a3b8;font-size:11px;font-weight:500;margin-top:4px}.nav{display:grid;gap:5px}.nav button{border:0;background:transparent;color:#cbd5e1;text-align:left;padding:11px 12px;border-radius:9px;cursor:pointer;font-size:14px}.nav button.active,.nav button:hover{background:#1f2937;color:white}.main{margin-left:250px;width:calc(100% - 250px);padding:26px 32px}.top{display:flex;justify-content:space-between;align-items:center;margin-bottom:24px}.title h1{margin:0;font-size:26px}.title p{margin:5px 0;color:var(--muted);font-size:13px}.actions{display:flex;gap:8px}.btn{border:1px solid var(--line);background:white;border-radius:8px;padding:9px 13px;font-weight:650;cursor:pointer}.btn.primary{background:var(--accent);color:white;border-color:var(--accent)}.btn.good{background:#ecfdf3;color:var(--good);border-color:#bbf7d0}.grid4{display:grid;grid-template-columns:repeat(4,1fr);gap:14px}.card{background:var(--card);border:1px solid var(--line);border-radius:13px;padding:18px}.kpi .label{color:var(--muted);font-size:12px}.kpi .num{font-size:27px;font-weight:800;margin-top:8px}.kpi .sub{font-size:11px;color:var(--muted);margin-top:4px}.section{margin-top:18px}.sectionhead{display:flex;justify-content:space-between;align-items:center;margin-bottom:10px}.sectionhead h2{font-size:16px;margin:0}.table{overflow:hidden}.row{display:grid;grid-template-columns:1.1fr 1.7fr 1fr .7fr .7fr 1fr;gap:12px;align-items:center;padding:13px 15px;border-top:1px solid var(--line);font-size:13px}.thead{background:#f8fafc;color:var(--muted);font-size:11px;font-weight:700;border-top:0}.pill{display:inline-flex;padding:4px 8px;border-radius:999px;background:#fff7ed;color:var(--warn);font-size:11px;font-weight:700}.pill.good{background:#ecfdf3;color:var(--good)}.confidence{font-weight:800}.muted{color:var(--muted)}.source{font-size:11px;color:#64748b}.layout2{display:grid;grid-template-columns:1.5fr 1fr;gap:18px}.field{margin-bottom:13px}.field label{display:block;font-size:11px;color:var(--muted);font-weight:700;margin-bottom:6px}.field input,.field select,.field textarea{width:100%;border:1px solid var(--line);border-radius:8px;padding:10px;background:white}.preview{border:1px dashed #cbd5e1;border-radius:12px;padding:18px;background:#fafbff}.doc{display:flex;align-items:center;gap:12px;border:1px solid var(--line);padding:10px;border-radius:9px;background:white;margin-top:8px}.docicon{width:38px;height:44px;border-radius:7px;background:#eef2ff;display:grid;place-items:center;color:var(--accent);font-weight:800}.modal{position:fixed;inset:0;background:rgba(15,23,42,.42);display:none;align-items:center;justify-content:center;padding:20px}.modal.open{display:flex}.modalbox{width:min(760px,95vw);background:white;border-radius:16px;padding:22px}.close{float:right;border:0;background:#f1f5f9;border-radius:8px;padding:7px 10px;cursor:pointer}.empty{padding:40px;text-align:center;color:var(--muted)}
    @media(max-width:1000px){.grid4{grid-template-columns:repeat(2,1fr)}.layout2{grid-template-columns:1fr}.side{width:210px}.main{margin-left:210px;width:calc(100% - 210px)}}
    @media(max-width:700px){.side{display:none}.main{margin-left:0;width:100%;padding:18px}.grid4{grid-template-columns:1fr 1fr}.row{grid-template-columns:1fr 1fr}.thead{display:none}}
  </style>
</head>
<body>
<div class="app">
  <aside class="side">
    <div class="brand">NUNES CRM <small>AI Product Intelligence</small></div>
    <div class="nav">
      <button class="active" onclick="show('dashboard',this)">◈ Dashboard</button>
      <button onclick="show('inbox',this)">✉ Extraction Inbox</button>
      <button onclick="show('products',this)">▦ Product Master</button>
      <button onclick="show('documents',this)">▤ Documents</button>
      <button onclick="show('price',this)">₹ Price Intelligence</button>
      <button onclick="show('composer',this)">↗ Communication</button>
    </div>
  </aside>

  <main class="main">
    <div id="dashboard" class="page">
      <div class="top"><div class="title"><h1>Product Intelligence</h1><p>Gmail + PDF + attachment extraction, validation and product master.</p></div><div class="actions"><button class="btn" onclick="testPipeline()">Test pipeline</button><button class="btn primary" onclick="show('inbox')">Review candidates</button></div></div>
      <div class="grid4">
        <div class="card kpi"><div class="label">New candidates</div><div class="num">18</div><div class="sub">from recent sources</div></div>
        <div class="card kpi"><div class="label">Needs review</div><div class="num">6</div><div class="sub">human validation</div></div>
        <div class="card kpi"><div class="label">Product master</div><div class="num">428</div><div class="sub">active products</div></div>
        <div class="card kpi"><div class="label">Auto-matched</div><div class="num">91%</div><div class="sub">model/part matches</div></div>
      </div>
      <div class="section layout2">
        <div class="card table"><div class="sectionhead"><h2>Latest extraction candidates</h2><span class="muted">Human-in-the-loop</span></div>
          <div class="row thead"><div>ID</div><div>Product</div><div>Source</div><div>Confidence</div><div>Price</div><div>Status</div></div>
          <div class="row"><div>PC-1042</div><div><b>Digital Multimeter DM-9208</b><div class="source">Model DM-9208</div></div><div class="source">Gmail / PDF</div><div class="confidence">96%</div><div>₹2,450</div><div><span class="pill">Review</span></div></div>
          <div class="row"><div>PC-1043</div><div><b>Clamp Meter CM-3286</b><div class="source">Model CM-3286</div></div><div class="source">Gmail / PDF</div><div class="confidence">88%</div><div>₹4,900</div><div><span class="pill">Review</span></div></div>
          <div class="row"><div>PC-1044</div><div><b>Insulation Tester IT-500</b><div class="source">Model IT-500</div></div><div class="source">Gmail / PDF</div><div class="confidence">72%</div><div>₹8,750</div><div><span class="pill">Needs review</span></div></div>
        </div>
        <div class="card"><div class="sectionhead"><h2>Extraction flow</h2></div><div class="preview"><b>1. Gmail source</b><p class="muted">Find approved sender/label and fetch message.</p><b>2. Attachments</b><p class="muted">Save/read PDF, image or spreadsheet.</p><b>3. NLP extraction</b><p class="muted">Extract product, model, part number and price.</p><b>4. Entity matching</b><p class="muted">Match against Product Master.</p><b>5. Human review</b><p class="muted">Approve before updating master data.</p></div></div>
      </div>
    </div>

    <div id="inbox" class="page" style="display:none">
      <div class="top"><div class="title"><h1>Extraction Inbox</h1><p>Review AI-extracted product candidates before they enter the master.</p></div><button class="btn primary" onclick="openModal()">Open candidate</button></div>
      <div class="card table"><div class="row thead"><div>ID</div><div>Extracted product</div><div>Source</div><div>Confidence</div><div>Price</div><div>Action</div></div>
        <div class="row"><div>PC-1042</div><div><b>Digital Multimeter DM-9208</b><div class="source">Model: DM-9208 • Part: 9208</div></div><div class="source">Quote_2026_08.pdf</div><div class="confidence">96%</div><div>₹2,450</div><div><button class="btn good" onclick="openModal()">Review</button></div></div>
        <div class="row"><div>PC-1043</div><div><b>Clamp Meter CM-3286</b><div class="source">Model: CM-3286</div></div><div class="source">Price_List_Aug.pdf</div><div class="confidence">88%</div><div>₹4,900</div><div><button class="btn good" onclick="openModal()">Review</button></div></div>
      </div>
    </div>

    <div id="products" class="page" style="display:none">
      <div class="top"><div class="title"><h1>Product Master</h1><p>Single source of truth for normalized products.</p></div><div class="actions"><button class="btn">Import</button><button class="btn primary">+ Add product</button></div></div>
      <div class="card"><div class="actions" style="margin-bottom:12px"><input style="flex:1;border:1px solid var(--line);border-radius:8px;padding:10px" placeholder="Search product, model, part number..."><select class="btn"><option>All categories</option></select><select class="btn"><option>All status</option></select></div>
        <div class="table"><div class="row thead"><div>ID</div><div>Product</div><div>Model / Part</div><div>Category</div><div>Price</div><div>Status</div></div><div class="row"><div>PRD-0001</div><div><b>Digital Multimeter</b><div class="source">Nunes Instruments</div></div><div>DM-9208</div><div>Test Equipment</div><div>₹2,450</div><div><span class="pill good">Active</span></div></div><div class="row"><div>PRD-0002</div><div><b>Clamp Meter</b><div class="source">Nunes Instruments</div></div><div>CM-3286</div><div>Test Equipment</div><div>₹4,900</div><div><span class="pill good">Active</span></div></div></div>
      </div>
    </div>

    <div id="documents" class="page" style="display:none">
      <div class="top"><div class="title"><h1>Documents</h1><p>Drive-linked source files with traceability.</p></div><button class="btn primary">+ Select from Drive</button></div>
      <div class="card"><div class="doc"><div class="docicon">PDF</div><div style="flex:1"><b>Quote_2026_08.pdf</b><div class="source">Drive ID: 1abc...xyz • 2.4 MB • Source: Gmail</div></div><span class="pill good">Linked</span></div><div class="doc"><div class="docicon">PDF</div><div style="flex:1"><b>Price_List_Aug.pdf</b><div class="source">Drive ID: 1def...xyz • 1.8 MB • Source: Gmail</div></div><span class="pill good">Linked</span></div></div>
    </div>

    <div id="price" class="page" style="display:none">
      <div class="top"><div class="title"><h1>Price Intelligence</h1><p>Prices extracted from Gmail/PDF sources and linked to products.</p></div></div>
      <div class="grid4"><div class="card kpi"><div class="label">Price records</div><div class="num">1,284</div></div><div class="card kpi"><div class="label">This month</div><div class="num">+18%</div></div><div class="card kpi"><div class="label">Needs validation</div><div class="num">23</div></div><div class="card kpi"><div class="label">Sources processed</div><div class="num">76</div></div></div>
    </div>

    <div id="composer" class="page" style="display:none">
      <div class="top"><div class="title"><h1>Communication Composer</h1><p>Select exact buyer, template, files and location before sending.</p></div></div>
      <div class="layout2"><div class="card"><div class="field"><label>BUYER</label><input value="ABC Instruments Pvt Ltd"></div><div class="field"><label>CHANNEL</label><select><option>Gmail</option><option>WhatsApp</option></select></div><div class="field"><label>TEMPLATE</label><select><option>Product Introduction — v1</option><option>Price Follow-up — v2</option></select></div><div class="field"><label>LOCATION</label><select><option>Chennai</option><option>Coimbatore</option><option>Bengaluru</option></select></div><div class="field"><label>SELECTED FILES</label><div class="doc"><div class="docicon">PDF</div><div style="flex:1"><b>DM-9208_Catalogue.pdf</b><div class="source">Exact Drive File ID selected</div></div><button class="btn">×</button></div><div class="doc"><div class="docicon">PDF</div><div style="flex:1"><b>Price_List_Aug.pdf</b><div class="source">Exact Drive File ID selected</div></div><button class="btn">×</button></div></div><div class="actions"><button class="btn">Save draft</button><button class="btn primary">Validate & Send</button></div></div>
        <div class="card"><h2 style="font-size:16px">Live preview</h2><div class="preview"><b>Subject: Product Introduction — DM-9208</b><p>Dear ABC Instruments,</p><p>We are pleased to share the product information and current pricing for the selected instrument.</p><p><a href="#">View DM-9208 catalogue</a><br><a href="#">View price list</a></p><hr><b>Chennai Location</b><p class="muted">Scan the QR code to open the location in Google Maps.</p><div style="width:110px;height:110px;background:repeating-linear-gradient(45deg,#111 0 4px,#fff 4px 8px);border:8px solid white;box-shadow:0 0 0 1px #ddd"></div></div></div></div>
    </div>
  </main>
</div>

<div class="modal" id="modal"><div class="modalbox"><button class="close" onclick="closeModal()">Close</button><h2>Review Product Candidate</h2><p class="muted">AI extraction is a proposal. Verify before writing to Product Master.</p><div class="layout2"><div><div class="field"><label>PRODUCT NAME</label><input value="Digital Multimeter DM-9208"></div><div class="field"><label>MODEL / PART NUMBER</label><input value="DM-9208"></div><div class="field"><label>EXTRACTED PRICE</label><input value="₹2,450"></div><div class="field"><label>CONFIDENCE</label><input value="96%"></div></div><div class="preview"><b>Source trace</b><p class="source">Gmail: Supplier Quote</p><p class="source">Attachment: Quote_2026_08.pdf</p><p class="source">Drive File ID: 1abc...xyz</p><p class="source">Page: 2</p><p class="muted">This traceability lets a human verify the AI result.</p></div></div><div class="actions" style="justify-content:flex-end"><button class="btn">Reject</button><button class="btn good" onclick="closeModal()">Approve & Match</button></div></div></div>

<script>
function show(id,btn){document.querySelectorAll('.page').forEach(x=>x.style.display='none');document.getElementById(id).style.display='block';document.querySelectorAll('.nav button').forEach(x=>x.classList.remove('active'));if(btn)btn.classList.add('active');}
function openModal(){document.getElementById('modal').classList.add('open')}
function closeModal(){document.getElementById('modal').classList.remove('open')}
function testPipeline(){
  if(window.google && google.script){google.script.run.withSuccessHandler(r=>alert(r.message)).testExtraction();}
  else alert('Preview mode: UI is working. Apps Script backend will run after deployment.');
}
</script>
</body>
</html>
'@; ^
  $files['preview.html']=$files['Index.html']; ^
  foreach($k in $files.Keys){Set-Content -Path (Join-Path $p $k) -Value $files[$k] -Encoding UTF8}; ^
  Write-Host ('Created: '+$p)"

start "" "%ROOT%\preview.html"
echo.
echo CRM preview created in:
echo %ROOT%
echo.
echo Open preview.html to review the UI.
echo Copy Code.gs, Index.html and appsscript.json into a Google Apps Script project to deploy the web app.
pause
