<cfset pageTitle = "SDSTracker Create Hazard">
<cfinclude template="/ui/shared/head.cfm">
<cfinclude template="/ui/shared/header.cfm">
<body>
  <form class="form-signin" action="/rest/api/hazards/create" method="POST">
    <div class="text-center mb-4">
      <img class="mb-4" src="/assets/images/HealthHazard.png" alt="" width="72" height="72">
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

    <hr>
    <p class="text-secondary" style="font-size:0.85em; margin-bottom:0.5em;">
      Optional GHS / SDS fields - leave blank if not applicable.
    </p>
    <div class="form-label-group">
      <label for="hazardCategory">Hazard Category</label>
      <input name="hazardCategory" type="text" id="hazardCategory" class="form-control"
        placeholder="e.g. 1, 2A, 3"
        oninput="updateCategoryDisplay(this.value)">
      <div id="hazardCategoryError" class="text-danger" style="display:none;">
        Error: enter a category such as 1, 2, 2A, or 3
      </div>
    </div>
    <div class="form-label-group">
      <label>Routes of Exposure</label>
      <div class="d-flex flex-wrap" style="gap:0.5em;">
        <div class="form-check form-check-inline">
          <input class="form-check-input" type="checkbox" name="exposureRoutes" value="inhalation" id="routeInhalation">
          <label class="form-check-label" for="routeInhalation">Inhalation</label>
        </div>
        <div class="form-check form-check-inline">
          <input class="form-check-input" type="checkbox" name="exposureRoutes" value="skin contact" id="routeSkin">
          <label class="form-check-label" for="routeSkin">Skin Contact</label>
        </div>
        <div class="form-check form-check-inline">
          <input class="form-check-input" type="checkbox" name="exposureRoutes" value="eye contact" id="routeEye">
          <label class="form-check-label" for="routeEye">Eye Contact</label>
        </div>
        <div class="form-check form-check-inline">
          <input class="form-check-input" type="checkbox" name="exposureRoutes" value="ingestion" id="routeIngestion">
          <label class="form-check-label" for="routeIngestion">Ingestion</label>
        </div>
      </div>
      <input type="hidden" name="exposureRoutes" id="exposureRoutesHidden">
    </div>
    <div class="form-label-group">
      <label for="unNumber">UN Number</label>
      <input name="unNumber" type="text" id="unNumber" class="form-control"
        placeholder="e.g. UN1090"
        oninput="updateUnDisplay(this.value)">
      <div id="unNumberError" class="text-danger" style="display:none;">
        Error: format is UN followed by 4 digits (e.g. UN1090)
      </div>
    </div>

    <hr>
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

  function updateCategoryDisplay(value) {
    const errorEl = document.getElementById('hazardCategoryError');
    if (value.trim() === '' || /^[1-4][AB]?$/.test(value.trim())) {
      errorEl.style.display = 'none';
    } else {
      errorEl.style.display = 'block';
    }
  }
  function updateUnDisplay(value) {
    const errorEl = document.getElementById('unNumberError');
    if (value.trim() === '' || /^UN\d{4}$/.test(value.trim())) {
      errorEl.style.display = 'none';
    } else {
      errorEl.style.display = 'block';
    }
  }

  // Aggregate checkbox values into the hidden field before submit
  document.querySelector('form').addEventListener('submit', function() {
    const checked = Array.from(document.querySelectorAll('input[type="checkbox"][name="exposureRoutes"]:checked'))
      .map(cb => cb.value);
    document.getElementById('exposureRoutesHidden').value = checked.join(', ');
    document.querySelectorAll('input[type="checkbox"][name="exposureRoutes"]').forEach(cb => {
      cb.disabled = true;
    });
  });
</script>

<cfinclude template="/ui/shared/footer.cfm">
