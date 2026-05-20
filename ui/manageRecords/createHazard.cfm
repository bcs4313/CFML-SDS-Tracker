<cfset pageTitle = "SDSTracker Create Hazard">
<cfinclude template="/ui/shared/head.cfm">
<cfinclude template="/ui/shared/header.cfm">
<body>
  <form class="form-signin" action="/rest/api/hazards/create" method="POST">
    <div class="text-center mb-4">
      <img class="mb-4" src="/assets/images/atom-symbol.jpg" alt="" width="72" height="72">
      <h1 class="h3 mb-3 font-weight-normal">Create Hazard</h1>
      <p class="text-secondary">Define a GHS hazard entry to associate with chemicals in your inventory.</p>
    </div>
    
    <div class="form-label-group">
      <label for="hazardName">Hazard Name</label>
      <input name="hazardName" type="text" id="hazardName" class="form-control"
        placeholder="e.g. Flammable Liquid Cat. 1" required autofocus>
    </div>
    <div class="form-label-group">
      <label for="ghsHazardClass">GHS Hazard Class</label>
      <input name="ghsHazardClass" type="text" id="ghsHazardClass" class="form-control"
        placeholder="e.g. Flammable Liquid" required autofocus>
    </div>

    <div class="form-label-group">
      <label for="pictogramUrl">GHS Pictogram URL</label>
      <input name="pictogramUrl" type="url" id="pictogramUrl" class="form-control"
        placeholder="https://example.com/pictogram.png"
        oninput="updatePictogramPreview(this.value)">
      <div id="pictogramPreviewWrapper" style="display:none; margin-top:0.5em;">
        <img id="pictogramPreview" src="" alt="Pictogram Preview"
          style="width:64px;height:64px;object-fit:contain;border:1px solid #444;border-radius:4px;">
      </div>
    </div>

    <div class="form-label-group">
      <label for="signalWord">Signal Word</label>
      <select name="signalWord" id="signalWord" class="form-control" required>
        <option value="" disabled selected>-- Select Signal Word --</option>
        <option value="Danger">Danger</option>
        <option value="Warning">Warning</option>
      </select>
    </div>

    <div class="form-label-group">
      <label for="hCodes">Hazard Statements (H-codes)</label>
      <input name="hCodes" type="text" id="hCodes" class="form-control"
        placeholder="e.g. H225, H319"
        oninput="updateCodeDisplay('hCodes', 'hCodesError', validateCodes)">
      <div id="hCodesError" class="text-danger" style="display:none;">
        Error: use comma-separated H-codes (e.g. H225, H319)
      </div>
    </div>

    <div class="form-label-group">
      <label for="pCodes">Precautionary Statements (P-codes)</label>
      <input name="pCodes" type="text" id="pCodes" class="form-control"
        placeholder="e.g. P210, P233"
        oninput="updateCodeDisplay('pCodes', 'pCodesError', validateCodes)">
      <div id="pCodesError" class="text-danger" style="display:none;">
        Error: use comma-separated P-codes (e.g. P210, P233)
      </div>
    </div>

    <button class="btn btn-lg btn-primary btn-block" type="submit">Submit Hazard</button>
  </form>
</body>

<script>
  function updatePictogramPreview(url) {
    const wrapper = document.getElementById('pictogramPreviewWrapper');
    const img = document.getElementById('pictogramPreview');
    if (url && url.trim() !== '') {
      img.src = url.trim();
      wrapper.style.display = 'block';
    } else {
      wrapper.style.display = 'none';
      img.src = '';
    }
  }

  // Validates comma-separated H/P codes (e.g. H225, P210)
  function validateCodes(value) {
    if (value.trim() === '') return true; // optional field
    const parts = value.split(',').map(p => p.trim());
    return parts.every(part => /^[HP]\d{3,4}[A-Za-z]?$/.test(part));
  }

  function updateCodeDisplay(inputId, errorId, validatorFn) {
    const value = document.getElementById(inputId).value;
    const errorEl = document.getElementById(errorId);
    if (validatorFn(value)) {
      errorEl.style.display = 'none';
    } else {
      errorEl.style.display = 'block';
    }
  }
</script>

<cfinclude template="/ui/shared/footer.cfm">
