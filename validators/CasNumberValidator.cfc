component {
    public static boolean function validate(required string number) {
        try
        {
            var casNumSections = listToArray(number, "-");  // divide
            var rawNumberString = replace(number, "-", "");

            if(!isNumeric(rawNumberString)) { return false; }

            // number must consist of three sections
            if(ArrayLen(casNumSections) != 3) { return false; }
            
            // first section must be 2 to 7 digits long
            if(Len(casNumSections[1]) < 2) { return false; };
            if(Len(casNumSections[1]) > 7) { return false; };

            // second section is 2 digits
            if(Len(casNumSections[2]) != 2) { return false; };

            // third section is 1 digit (check digit)
            var checkDigit = casNumSections[3];
            if(Len(casNumSections[3]) != 1) { return false; };

            // verify the check digit
            var sumToCheck = 0;
            var weight = 1;
            for(i = (Len(rawNumberString)-1); i > 0; i--)
            {
                var c = rawNumberString[i];
                var cNum = asc(c);  // ascii val
                cNum -= 48;  // convert to digit

                cNum *= weight;
                sumToCheck += cNum;
                weight += 1;
            }
            var finalNum = sumToCheck % 10;

            return finalNum == (asc(checkDigit)-48);

        }
        catch (any e)
        {
            systemOutput("casNumber validation error -> " & e);
        }
        return false;
    } 
}