import csv

with open('/Users/vladyslavlopatin/PycharmProjects/akinator/generator/data.csv') as csv_file:
    with open('/Users/vladyslavlopatin/PycharmProjects/akinator/src/db.pl', 'w') as file:
        csv_reader = csv.reader(csv_file, delimiter=';')
        line_count = 0
        facts = []
        names = []
        for row in csv_reader:
            if line_count == 0:
                row.pop(0)
                file.write('get_questions(Q) :-\n')
                file.write('    ')
                file.write('Q = [' + ', '.join('\'{0}\''.format(w) for w in row) + '].\n\n')
                line_count += 1
            elif line_count == 1:
                row.pop(0)
                file.write('get_facts(F) :-\n')
                file.write('    ')
                facts = row
                file.write('F = [' + ', '.join(row) + '].\n\n')
                line_count += 1
            else:
                names.append(row.pop(0))
                for index, fact in enumerate(row):
                    if fact == '1':
                        file.write(facts[index] + '(' + names[-1] + ').\n')
                line_count += 1
        file.write('get_people(P) :-\n')
        file.write('    ')
        file.write('P = [' + ', '.join(names) + '].')
        print(f'Processed {line_count} lines.')
