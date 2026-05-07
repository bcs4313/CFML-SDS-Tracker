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
</script>

<cfinclude template="/ui/shared/footer.cfm">