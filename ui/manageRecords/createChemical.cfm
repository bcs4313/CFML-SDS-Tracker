<cfset pageTitle = "SDSTracker Create Chemical">
<cfinclude template="/ui/shared/head.cfm">
<cfinclude template="/ui/shared/header.cfm">
<body>
    <form class="form-signin" action="/rest/api/chemicals/create" method="POST">
        <div class="text-center mb-4">
            <img class="mb-4" src="/assets/images/atom-symbol.jpg" alt="" width="72" height="72">
            <h1 class="h3 mb-3 font-weight-normal">Create Chemical</h1>
            <p class="text-secondary">Create an element or compound to be managed in our inventory.</p>
        </div>

        <div class="form-label-group">
            <label for="chemicalName">Chemical Name</label>
            <input name="name" type="text" id="chemicalName" class="form-control" placeholder="Dihydrogen Monoxide" required="" autofocus="">
        </div>


        <div class="form-label-group">
            <label for="casNumber">CAS Number</label>
            <input name="casNumber" type="text" id="casNumber" class="form-control" placeholder="7732-18-5"
            oninput="updateCasDisplay(this.value)" required="" autofocus="">
            <div id="casError" class="text-danger" style="display: block">Error: please enter a valid CAS number</div>
        </div>

        <!-- optional field section -->
        <hr>
        <p class="text-secondary" style="font-size:0.85em; margin-bottom:0.5em;">
        Optional GHS / SDS fields. Leave blank if not applicable.
        </p>
        <div class="form-label-group">
        <label for="iupacName">IUPAC Name</label>
        <input name="iupacName" type="text" id="iupacName" class="form-control"
            placeholder="e.g. oxidane">
        </div>
        <div class="form-label-group">
        <label for="molecularFormula">Molecular Formula</label>
        <input name="molecularFormula" type="text" id="molecularFormula" class="form-control"
            placeholder="e.g. H2O"
            oninput="updateFormulaDisplay(this.value)">
        <div id="formulaError" class="text-danger" style="display:none;">
            Error: use Hill notation (e.g. C6H6, H2O, NaCl)
        </div>
        </div>
        <div class="form-label-group">
        <label for="physicalState">Physical State (at STP)</label>
        <select name="physicalState" id="physicalState" class="form-control">
            <option value="" selected>-- Not specified --</option>
            <option value="solid">Solid</option>
            <option value="liquid">Liquid</option>
            <option value="gas">Gas</option>
            <option value="unknown">Unknown</option>
        </select>
        </div>
        <div class="form-label-group">
        <label for="molecularWeight">Molecular Weight (g/mol)</label>
        <input name="molecularWeight" type="text" id="molecularWeight" class="form-control"
            placeholder="e.g. 18.015"
            oninput="updateMwDisplay(this.value)">
        <div id="mwError" class="text-danger" style="display:none;">
            Error: enter a positive numeric value (e.g. 18.015)
        </div>
        </div>

        <hr>
        <button class="btn btn-lg btn-primary btn-block" type="submit">Submit Chemical</button>
    </form>
  

</body>

<script>
    function updateCasDisplay(number) {

        console.log("test");
        if(validate(number))
        {
            document.getElementById('casError').style.display = 'none';
            console.log("casNumber input VALID");
        }
        else
        {
            document.getElementById('casError').style.display = 'block';
            console.log("casNumber input INVALID");
        }
    }

    function validate(number) {
    try {
        const casNumSections = number.split("-");                    // divide
        const rawNumberString = number.replace(/-/g, "");

        if (isNaN(rawNumberString) || rawNumberString === "") { return false; }

        // number must consist of three sections
        if (casNumSections.length !== 3) { return false; }

        // first section must be 2 to 7 digits long
        if (casNumSections[0].length < 2) { return false; }
        if (casNumSections[0].length > 7) { return false; }

        // second section is 2 digits
        if (casNumSections[1].length !== 2) { return false; }

        // third section is 1 digit (check digit)
        const checkDigit = casNumSections[2];
        if (casNumSections[2].length !== 1) { return false; }

        // verify the check digit
        let sumToCheck = 0;
        let weight = 1;
        for (let i = rawNumberString.length - 2; i >= 0; i--) {
            const c = rawNumberString[i];
            let cNum = c.charCodeAt(0);  // ascii val
            cNum -= 48;  // convert to digit

            cNum *= weight;
            sumToCheck += cNum;
            weight += 1;
        }
        const finalNum = sumToCheck % 10;

        return finalNum === (checkDigit.charCodeAt(0) - 48);

    } catch (e) {
        console.error("casNumber validation error -> " + e);
    }
        return false;
    }

    function updateFormulaDisplay(value) {
        const errorEl = document.getElementById('formulaError');
        if (value.trim() === '' || /^[A-Za-z][A-Za-z0-9]*$/.test(value.trim())) {
            errorEl.style.display = 'none';
        } else {
            errorEl.style.display = 'block';
        }
    }
    function updateMwDisplay(value) {
        const errorEl = document.getElementById('mwError');
        if (value.trim() === '' || /^\d+(\.\d+)?$/.test(value.trim())) {
            errorEl.style.display = 'none';
        } else {
            errorEl.style.display = 'block';
        }
    }
</script>

<cfinclude template="/ui/shared/footer.cfm">