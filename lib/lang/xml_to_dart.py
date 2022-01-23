import csv

footer = "};\n"

def save(langKey, values):
    parsed = langKey.split('|')
    firstName = parsed[1]
    secondName = parsed[2]
    fileName = "{}_{}".format(firstName, secondName.lower())
    mapName = "{}{}".format(firstName, secondName.upper())

    with open("lib/lang/{}.dart".format(fileName), "w") as result:
        result.write("const Map<String, String> {} = ".format(mapName) + "{ \n")
        for keyVal in values:
            result.write("\t'{}': {},\n".format(keyVal[0], repr(keyVal[1])))
        result.write(footer)

with open('lib/lang/casting_lots.csv', newline='') as csvfile:
    reader = csv.DictReader(csvfile)
    languages = {}
    for row in reader:
        for rowKey in row:
            if rowKey == "Key":
                continue
            
            if rowKey in languages:
                languages[rowKey].append([row["Key"], row[rowKey]])
            else:
                languages[rowKey] = [[row["Key"], row[rowKey]]]

    for lang in languages:
        save(lang, languages[lang])