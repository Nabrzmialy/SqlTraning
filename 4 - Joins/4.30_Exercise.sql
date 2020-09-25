
/* TIME FUNCTIONS */

/* Returning the current date and time */
CURRENT_TIMESTAMP	-- Returns the current system date and time without the time zone part.
GETUTCDATE	-- Returns a date part of a date as an integer number.
GETDATE	--  Returns the current system date and time of the operating system on which the SQL Server is running.
SYSDATETIME	-- Returns the current system date and time with more fractional seconds precision than the GETDATE() function.
SYSUTCDATETIME	-- Returns the current system date and time in UTC time
SYSDATETIMEOFFSET	-- Returns the current system date and time with the time zone.

/* Returning the date and time Parts */
DATENAME	-- Returns a date part of a date as a character string
DATEPART	-- Returns a date part of a date as an integer number
DAY			-- Returns the day of a specified date as an integer
MONTH		-- Returns the month of a specified date as an integer
YEAR		-- Returns the year of the date as an integer.

-- Ex 1.: What is the difference between DATENAME and DATEPART?
-- Ex 2.: SELECT sum of day, month, year of Current GetDate()


/* Returning a difference between two dates */
DATEDIFF	-- Returns a difference in date part between two dates

-- Ex 3.: In what scale datediff can be returned?

/* Modifying dates */
DATEADD				-- Adds a value to a date part of a date and return the new date value.
EOMONTH				-- Returns the last day of the month containing the specified date, with an optional offset.
SWITCHOFFSET		-- Changes the time zone offset of a DATETIMEOFFSET value and preserves the UTC value.
TODATETIMEOFFSET	-- Transforms a DATETIME2 value into a DATETIMEOFFSET value.

-- Ex 4.: Add 50 days, 1 month, 2 years to current date.

/* Constructing date and time from their parts */
DATEFROMPARTS			-- Return a DATE value from the year, month, and day.
DATETIME2FROMPARTS		-- Returns a DATETIME2 value from the date and time arguments
DATETIMEOFFSETFROMPARTS	-- Returns a DATETIMEOFFSET value from the date and time arguments
TIMEFROMPARTS			-- Returns a TIME value from the time parts with the precisions



/* Validating date and time values */
ISDATE					--Check if a value is a valid date, time, or datetime value
-------------------------------------------------------------------------------------------------------------

/* SQL SERVER STRING FUNCTIONS */
ASCII			-- Return the ASCII code value of a character
CHAR			-- Convert an ASCII value to a character
CHARINDEX		-- Search for a substring inside a string starting from a specified location and return the position of the substring.
CONCAT			-- Join two or more strings into one string
CONCAT_WS		-- Concatenate multiple strings with a separator into a single string
DIFFERENCE		-- Compare the SOUNDEX() values of two strings
FORMAT			-- Return a value formatted with the specified format and optional culture
LEFT			-- Extract a given a number of characters from a character string starting from the left
LEN				-- Return a number of characters of a character string
LOWER			-- Convert a string to lowercase
LTRIM			-- Return a new string from a specified string after removing all leading blanks
NCHAR			-- Return the Unicode character with the specified integer code, as defined by the Unicode standard
PATINDEX		-- Returns the starting position of the first occurrence of a pattern in a string.
QUOTENAME		-- Returns a Unicode string with the delimiters added to make the input string a valid delimited identifier
REPLACE			-- Replace all occurrences of a substring, within a string, with another substring
REPLICATE		-- Return a string repeated a specified number of times
REVERSE			-- Return the reverse order of a character string
RIGHT			-- Extract a given a number of characters from a character string starting from the right
RTRIM			-- Return a new string from a specified string after removing all trailing blanks
SOUNDEX			-- Return a four-character (SOUNDEX) code of a string based on how it is spoken
SPACE			-- Returns a string of repeated spaces.
STR				-- Returns character data converted from numeric data.
STRING_AGG		-- Concatenate rows of strings with a specified separator into a new string
STRING_ESCAPE	-- Escapes special characters in a string and returns a new string with escaped characters
STRING_SPLIT	-- A table-valued function that splits a string into rows of substrings based on a specified separator.
STUFF			-- Delete a part of a string and then insert another substring into the string starting at a specified position.
SUBSTRING		-- Extract a substring within a string starting from a specified location with a specified length
TRANSLATE		-- Replace several single-characters, one-to-one translation in one operation.
TRIM			-- Return a new string from a specified string after removing all leading and trailing blanks
UNICODE			-- Returns the integer value, as defined by the Unicode standard, of a character.
UPPER			-- Convert a string to uppercase

-------------------------------------------------------------------------------------------------------------

/* SQL SERVER SYSTEM FUNCTIONS */

CAST		--– cast a value of one type to another.
CONVERT		--– convert a value of one type to another.
CHOOSE		--– return one of the two values based on the result of the first argument.
ISNULL		--– replace NULL with a specified value.
ISNUMERIC	--– check if an expression is a valid numeric type.
IIF			--– add if-else logic to a query.
TRY_CAST	--– cast a value of one type to another and return NULL if the cast fails.
TRY_CONVERT --– convert a value of one type to another and return the value to be translated into the specified type. It returns NULL if the cast fails.
TRY_PARSE	--– convert a string to a date/time or a number and return NULL if the conversion fails.

-- Ex. 5 What is the difference between cast/convert/try_cast/try_convert/try_parse?
