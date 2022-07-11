#= Important things to know:
    password.txt file contains the password in this format:
        "name of password" "encrypted password" "date"
    id.txt file contains the credentials of user in this format:
        "username" "password" "hint" "status" =#

#= Importing Package =#
using Dates

#= Declaring global variable for credentials =#
credentials = []

#= Array of characters used for generating
    different type of password =#
alphanumeric_Special_Characters = ['A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z', 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, '@', '!', '%', '&', '(', ')', '/', 'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z']
alphanumeric = ['A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z', 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z']
characters_Only = ['A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z', 'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z']
numbers_Only = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]

#= Function for main menu screen =#
function main_Menu()
    #= Output the main menu choices =#
    clear()
    user_Choice = 0
    println("\n\nWelcome to Password Manager")
    println("\nMenu:")
    println("1.] Generate Password")
    println("2.] Password Vault")
    println("3.] Password Strength Test")
    println("4.] Change credentials")
    println("5.] Exit Program")

    #= Error handling for user's input =#
    try
        user_Choice = parse(Int64, Base.prompt("\nSelect a number"))
    catch
        println("You entered an invalid input. Please wait")
        sleep(2)
        main_Menu()
    end

    #= If else statement based on user's input =#
    if (user_Choice == 1)
        #= Go to generate passwrd =#
        generate_Password()
        main_Menu()
    elseif (user_Choice == 2)
        #= Go to Password Vault =#
        password_Vault()
        main_Menu()
    elseif (user_Choice == 3)
        #= Go to password strength test =#
        password_Test_Strength()
        main_Menu()
    elseif (user_Choice == 4)
        #= Go to change credentials =#
        change_Credentials(credentials)
        main_Menu()
    elseif (user_Choice == 5)
        #= Go to exit message =#
        exit_Message()
    else
        println("You entered an invalid input. Please wait")
        sleep(2)
        main_Menu()
    end
end

#= Function for clearing screen =#
function clear()
    #= Clear function for clearing the screen =#
    print("\e[0;0H\e[2J")
end

#= Function for decrypting password =#
function decryptor(password)
    #= Initialize holder variable =#
    temp_Holder = Any[]
    decrypted_String = Any[]

    #= Convert the password into its ASCII value and minus 5 to it 
        and hold it to temp_Holder=#
    for i in password
        push!(temp_Holder, (Int(i) - 5))
    end

    #= Reiterate the temp_Holder and revert it back to character value =#
    for i in temp_Holder
        push!(decrypted_String, Char(i))
    end

    #= Join the encrypted array into string and return it =#
    result_String = join(decrypted_String)
    return result_String
end

#= Function for encrypting password =#
function encryptor(password)
    #= Initialize holder variable =#
    temp_Holder = Any[]
    encrypted_String = Any[]

    #= Convert the password into its ASCII value and add 5 to it 
        and hold it to temp_Holder=#
    for i in password
        push!(temp_Holder, (Int(i) + 5))
    end

    #= Reiterate the temp_Holder and revert it back to character value =#
    for i in temp_Holder
        push!(encrypted_String, Char(i))
    end

    #= Join the encrypted array into string and return it =#
    result_String = join(encrypted_String)
    return result_String
end

#= Function for generating password =#
function generate_Password()
    #= Screen for generating password menu =#
    clear()
    println("\t\t\n\nGenerate a Password")
    println("1.] Alphanumeric with Special Characters")
    println("2.] Alphanumeric Only")
    println("3.] Characters Only")
    println("4.] Numbers Only")
    println("5.] Back to main menu")

    #= Initialize empty variables =#
    password_Temp_Holder = Any[]
    password_String = Any[]
    password_Type = 0
    password_Length = 0
    user_choice = 0

    #= Error handling for 
        different type of user input =#
    try
        password_Type = parse(Int64, Base.prompt("\nPassword type"))
    catch
        println("Enter a viable password type")
        sleep(3)
        generate_Password()
    end
    if (password_Type == 5)
        main_Menu()
    elseif (password_Type > 5)
        println("Enter a viable password type")
        sleep(3)
        generate_Password()
    end

    print("Name of password: ")
    password_Name = readline()
    #= Error handling for 
        different type of user input =#
    try
        password_Length = parse(Int64, Base.prompt("How long should the password be (10-18)"))
    catch
        println("Enter a viable password length")
        sleep(3)
        generate_Password()
    end
    if (password_Length > 18 || password_Length < 10)
        println("Enter a viable password length")
        sleep(3)
        generate_Password()
    end

    #= If else for the password type =#
    if (password_Type == 1)
        for i in (1:password_Length)
            push!(password_Temp_Holder, alphanumeric_Special_Characters[rand(1:69)])
        end
        password_String = join(password_Temp_Holder)
    elseif (password_Type == 2)
        for i in (1:password_Length)
            push!(password_Temp_Holder, alphanumeric[rand(1:62)])
        end
        password_String = join(password_Temp_Holder)
    elseif (password_Type == 3)
        for i in (1:password_Length)
            push!(password_Temp_Holder, characters_Only[rand(1:52)])
        end
        password_String = join(password_Temp_Holder)
    elseif (password_Type == 4)
        for i in (1:password_Length)
            push!(password_Temp_Holder, numbers_Only[rand(1:10)])
        end
        password_String = join(password_Temp_Holder)
    end

    #= Creating a temporary holder for the needed strings =#
    pass = String(password_String)
    encrypted_Password = encryptor(password_String)
    result = join([password_Name, encrypted_Password, today(), "\n"], " ")

    #= Output the result =#
    clear()
    println("\n\nResult")
    println("Password Name: " * password_Name)
    println("Password: " * password_String)

    print("\nSave this result? [Y/N]: ")
    user_confirm = readline()
    if (user_confirm == "Y")
        #= Append the output strings to the file =#
        file = open("password.txt", "a+")
        write(file, result)
        close(file)
        #= After successfully generating a password,
        overwrite the value of 0 in credentials to 1
            to indicate that there is a password
                currently in the vault =#
        credentials[1][4] = "1"
        new_Credentials = join([credentials[1][1], credentials[1][2], credentials[1][3], credentials[1][4]], " ")
        credentials_File = open("id.txt", "w")
        write(credentials_File, new_Credentials)
        close(credentials_File)
    elseif (user_confirm == "N")
        generate_Password()
    else
        println("Invalid input...")
        print("Going back to menu...")
        sleep(2)
    end

    #= Output the finished screen =#
    clear()
    println("Password successfully stored.")
    sleep(1.5)
    clear()
    println("\n\nWhat do you want")
    println("\n1.] Generate another password")
    println("2.] Go back to menu")

    #= Error handling and if else function for user's choice =#
    try
        user_choice = parse(Int64, Base.prompt("Select"))
    catch
        println("Enter a valid input...")
        print("Returning back to main menu...")
        sleep(3)
    end
    if (user_choice == 1)
        generate_Password()
    elseif (user_choice == 2)
        main_Menu()
    else
        main_Menu()
    end
end

#= Function for the password vault =#
function password_Vault()
    #= Check if the value in credentials is 0,
        if 0, return back as there is no password in the vault =#
    if (credentials[1][4] == "0")
        println("There is currently no password in the vault...")
        print("Returning back to Main Menu...")
        sleep(3)
        main_Menu()
    end

    #= Initialize variables =#
    password_Temp_Holder = Any[]
    password_String = Any[]
    number_of_Passwords = 0
    password_Holder = Any[]
    deleteChoice = 0
    change_Choice = 0
    vault_Choice = 0

    #= Open the text file of the passwords and reiterate =#
    open("password.txt") do f
        while !eof(f)
            # Read a new / next line for every iteration          
            line = readline(f)
            #= Increment the number of password and 
                push it into the password holder array =#
            number_of_Passwords += 1
            push!(password_Holder, split(line, " "))
        end
    end

    #= Print the values inside the password holder =#
    clear()
    println("Here is the list of your passwords")
    for i in 1:number_of_Passwords
        print(i)
        print(".] ")
        print(password_Holder[i][1])
        print("\t")
        print(decryptor(password_Holder[i][2]))
        print("\t")
        print(password_Holder[i][3])
        print("\n")
    end

    #= Display the menu screen =#
    println("\n\nPlease select an option:")
    println("1.]Do you want to make changes?")
    println("2.]Do you want to delete a password?")
    println("3.]Return back to main menu")

    try
        vault_Choice = parse(Int64, Base.prompt("Please select a number"))
    catch
        println("Invalid input...")
        print("Going back to menu...")
        sleep(2)
        password_Vault()
    end
    #= Choice for making changes =#
    if (vault_Choice == 1)
        try
            change_Choice = parse(Int64, Base.prompt("Please select a password to modify"))
        catch
            println("Invalid input...")
            print("Going back to menu...")
            sleep(2)
            password_Vault()
        end
        if change_Choice <= number_of_Passwords
            #= Initialize variables =#
            password_Type = 0
            password_Length = 0
            print("\n\n")
            print(password_Holder[change_Choice][1])
            print("  ")
            print(decryptor(password_Holder[change_Choice][2]))
            println("\n1.] Alphanumeric with Special Characters")
            println("2.] Alphanumeric Only")
            println("3.] Characters Only")
            println("4.] Numbers Only")

            #= Error handling for user input =#
            try
                password_Type = parse(Int64, Base.prompt("\nPassword type"))
                if (password_Type > 4 || password_Type < 0)
                    println("Invalid input...")
                    print("Going back to menu...")
                    sleep(2)
                    password_Vault()
                end
                password_Length = parse(Int64, Base.prompt("How long should the password be (10-18)"))
            catch
                println("Invalid input...")
                print("Going back to menu...")
                sleep(2)
                password_Vault()
            end

            if (password_Length > 18 || password_Length < 10)
                println("Invalid input...")
                print("Going back to menu...")
                sleep(2)
                password_Vault()
            end

            #= If else statement for the password type =#
            #= Select a desire password type based on user input =#
            if (password_Type == 1)
                for i in (1:password_Length)
                    push!(password_Temp_Holder, alphanumeric_Special_Characters[rand(1:69)])
                end
                password_String = join(password_Temp_Holder)
            elseif (password_Type == 2)
                for i in (1:password_Length)
                    push!(password_Temp_Holder, alphanumeric[rand(1:62)])
                end
                password_String = join(password_Temp_Holder)
            elseif (password_Type == 3)
                for i in (1:password_Length)
                    push!(password_Temp_Holder, characters_Only[rand(1:52)])
                end
                password_String = join(password_Temp_Holder)
            elseif (password_Type == 4)
                for i in (1:password_Length)
                    push!(password_Temp_Holder, numbers_Only[rand(1:10)])
                end
                password_String = join(password_Temp_Holder)
            else
                println("Invalid input...")
                print("Going back to menu...")
                sleep(2)
            end

            password_Holder[change_Choice][2] = password_String

            #= Output the new password result =#
            print("The new password for ")
            print(password_Holder[change_Choice][1])
            print(" is ")
            println(password_Holder[change_Choice][2])
            print("Returning to main menu...")
            sleep(3)

            #= Open the file and rewrite the whole password_Holder =#
            modify_File = open("password.txt", "w")
            for i in 1:number_of_Passwords
                if (i == change_Choice)
                    new_Result = join([password_Holder[i][1], encryptor(password_Holder[i][2]), today(), "\n"], " ")
                    write(modify_File, new_Result)
                else
                    new_Result = join([password_Holder[i][1], password_Holder[i][2], today(), "\n"], " ")
                    write(modify_File, new_Result)
                end
            end
            close(modify_File)
        else
            println("Incorrect input. Please select again")
            sleep(1)
            password_Vault()
        end
    elseif (vault_Choice == 2)
        #= Error handling for user input =#
        try
            deleteChoice = parse(Int64, Base.prompt("Please select a password to delete"))
            if (deleteChoice > number_of_Passwords || deleteChoice < 0)
                println("Indvalid input.")
                print("Returning back to menu...")
                sleep(3.5)
                password_Vault()
            end
        catch
            println("Indvalid input.")
            print("Returning back to menu...")
            sleep(3.5)
            password_Vault()
        end

        #= Push all the data inside password_Holder to temp_Holder 
            except the user's input number =#
        temp_Holder = []
        for i in 1:number_of_Passwords
            if (i != deleteChoice)
                push!(temp_Holder, password_Holder[i])
            end
        end

        #= Open the text file and re-write the data in temp_Holder =#
        deleteFile = open("password.txt", "w")
        for i in 1:(number_of_Passwords-1)
            new_Result = join([temp_Holder[i][1], temp_Holder[i][2], today(), "\n"], " ")
            write(deleteFile, new_Result)
        end
        close(deleteFile)
        println("The password is now deleted...")
        sleep(3.5)

        #= Minus one the number of passwords =#
        number_of_Passwords -= 1

        #= If the password goes to 0,
            change the credentials[1][4] to 0 indicating that
                there are no passwords in the vault =#
        if (number_of_Passwords == 0)
            credentials[1][4] = "0"
            credentials_Holder = join([credentials[1][1], credentials[1][2], credentials[1][3], credentials[1][4]], " ")
            id = open("id.txt", "w+")
            write(id, credentials_Holder)
            close(id)
        end
    elseif (vault_Choice == 3)
        main_Menu()
    else
        println("Invalid input...")
        print("Going back to menu...")
        sleep(2)
        password_Vault()
    end
end

#= Function for testing password strength =#
function password_Test_Strength()
    #= Password Strength Test Menu =#
    clear()
    println("\n\nTest your password's strength")
    println("\n1.]Input your own password to test.")
    println("2.]Main Menu. \n\n")

    print("Select: ")
    answer = readline()

    if answer == "1"
        print("Please input your password:")
        passTest = readline()

        global low = 0
        global up = 0
        global num = 0
        global spec = 0
        lengthPass = sizeof(passTest)

        #= Reiterate the password and check if there is
            low and high cased char, number, and special character =#
        for i in passTest
            if Int(i) >= Int(97) && Int(i) <= Int(122)
                global low = 1
            end
            if Int(i) >= Int(65) && Int(i) <= Int(90)
                global up = 1
            end
            if Int(i) >= Int(48) && Int(i) <= Int(57)
                global num = 1
            end
            if Int(i) >= Int(37) && Int(i) <= Int(41)
                global spec = 1
            end
            if Int(i) == Int(64) && Int(i) == Int(33) && Int(i) == Int(47)
                global spec = 1
            end
        end

        print("\nPassword length is:")
        print(lengthPass)

        print("\nIt will take ")

        #= If else statement based on the password strength table =#
        if lengthPass <= 5
            print("0.00 second/s")
        elseif lengthPass == 6
            if num == 1 && low == 0 && up == 0 && spec == 0
                print("0.00 second/s")
            elseif num == 0 && low == 1 && up == 0 && spec == 0
                print("0.00 second/s")
            elseif num == 0 && low == 1 && up == 1 && spec == 0
                print("0.00 second/s")
            elseif num == 1 && low == 1 && up == 1 && spec == 0
                print("1.00 second/s")
            elseif num == 1 && low == 1 && up == 1 && spec == 1
                print("5.00 second/s")
            end
        elseif lengthPass == 7
            if num == 1 && low == 0 && up == 0 && spec == 0 #numbers only
                print("0.00 second/s")
            elseif num == 0 && low == 1 && up == 0 && spec == 0 #lower only
                print("0.00 second/s")
            elseif num == 0 && low == 1 && up == 1 && spec == 0 #lower + upper
                print("25.00 second/s")
            elseif num == 1 && low == 1 && up == 1 && spec == 0 # lower + upper + number
                print("60.00 second/s")
            elseif num == 1 && low == 1 && up == 1 && spec == 1 # all
                print("6.00 minute/s")
            end
        elseif lengthPass == 8
            if num == 1 && low == 0 && up == 0 && spec == 0 #numbers only
                print("0.00 seconds")
            elseif num == 0 && low == 1 && up == 0 && spec == 0 #lower only
                print("5.00 seconds")
            elseif num == 0 && low == 1 && up == 1 && spec == 0 #lower + upper
                print("25.00 seconds")
            elseif num == 1 && low == 1 && up == 1 && spec == 0 # lower + upper + number
                print("60.00 seconds")
            elseif num == 1 && low == 1 && up == 1 && spec == 1 # all
                print("8.00 hours")
            end
        elseif lengthPass == 9
            if num == 1 && low == 0 && up == 0 && spec == 0 #numbers only
                print("0.00 seconds")
            elseif num == 0 && low == 1 && up == 0 && spec == 0 #lower only
                print("2.00 minutes")
            elseif num == 0 && low == 1 && up == 1 && spec == 0 #lower + upper
                print("19.00 hours")
            elseif num == 1 && low == 1 && up == 1 && spec == 0 # lower + upper + number
                print("3 days")
            elseif num == 1 && low == 1 && up == 1 && spec == 1 # all
                print("3 weeks")
            end
        elseif lengthPass == 10
            if num == 1 && low == 0 && up == 0 && spec == 0 #numbers only
                print("0.00 seconds")
            elseif num == 0 && low == 1 && up == 0 && spec == 0 #lower only
                print("58.00 minutes")
            elseif num == 0 && low == 1 && up == 1 && spec == 0 #lower + upper
                print("1 month")
            elseif num == 1 && low == 1 && up == 1 && spec == 0 # lower + upper + number
                print("7 months")
            elseif num == 1 && low == 1 && up == 1 && spec == 1 # all
                print("5 years")
            end
        elseif lengthPass == 11
            if num == 1 && low == 0 && up == 0 && spec == 0 #numbers only
                print("0.00 seconds")
            elseif num == 0 && low == 1 && up == 0 && spec == 0 #lower only
                print("58.00 minutes")
            elseif num == 0 && low == 1 && up == 1 && spec == 0 #lower + upper
                print("1 month")
            elseif num == 1 && low == 1 && up == 1 && spec == 0 # lower + upper + number
                print("7 months")
            elseif num == 1 && low == 1 && up == 1 && spec == 1 # all
                print("5 years")
            end
        elseif lengthPass == 12
            if num == 1 && low == 0 && up == 0 && spec == 0 #numbers only
                print("25.00 seconds")
            elseif num == 0 && low == 1 && up == 0 && spec == 0 #lower only
                print("3 weeks")
            elseif num == 0 && low == 1 && up == 1 && spec == 0 #lower + upper
                print("300 years")
            elseif num == 1 && low == 1 && up == 1 && spec == 0 # lower + upper + number
                print("2,000 years")
            elseif num == 1 && low == 1 && up == 1 && spec == 1 # all
                print("34,000 years")
            end
        elseif lengthPass == 13
            if num == 1 && low == 0 && up == 0 && spec == 0 #numbers only
                print("4.00 minutes")
            elseif num == 0 && low == 1 && up == 0 && spec == 0 #lower only
                print("1 year")
            elseif num == 0 && low == 1 && up == 1 && spec == 0 #lower + upper
                print("16,000 years")
            elseif num == 1 && low == 1 && up == 1 && spec == 0 # lower + upper + number
                print("100,000 years")
            elseif num == 1 && low == 1 && up == 1 && spec == 1 # all
                print("2 MILLION years")
            end
        elseif lengthPass == 14
            if num == 1 && low == 0 && up == 0 && spec == 0 #numbers only
                print("41.00 minutes")
            elseif num == 0 && low == 1 && up == 0 && spec == 0 #lower only
                print("51 years")
            elseif num == 0 && low == 1 && up == 1 && spec == 0 #lower + upper
                print("800,000 years")
            elseif num == 1 && low == 1 && up == 1 && spec == 0 # lower + upper + number
                print("9 MILLION years")
            elseif num == 1 && low == 1 && up == 1 && spec == 1 # all
                print("200 MILLION years")
            end
        elseif lengthPass == 15
            if num == 1 && low == 0 && up == 0 && spec == 0 #numbers only
                print("6.00 hours")
            elseif num == 0 && low == 1 && up == 0 && spec == 0 #lower only
                print("1,000 years")
            elseif num == 0 && low == 1 && up == 1 && spec == 0 #lower + upper
                print("43 MILLION years")
            elseif num == 1 && low == 1 && up == 1 && spec == 0 # lower + upper + number
                print("600 MILLION years")
            elseif num == 1 && low == 1 && up == 1 && spec == 1 # all
                print("15 BILLION years")
            end
        elseif lengthPass == 16
            if num == 1 && low == 0 && up == 0 && spec == 0 #numbers only
                print("2 days")
            elseif num == 0 && low == 1 && up == 0 && spec == 0 #lower only
                print("34,000 years")
            elseif num == 0 && low == 1 && up == 1 && spec == 0 #lower + upper
                print("2 BILLION years")
            elseif num == 1 && low == 1 && up == 1 && spec == 0 # lower + upper + number
                print("37 BILLION years")
            elseif num == 1 && low == 1 && up == 1 && spec == 1 # all
                print("1 TRILLION years")
            end
        elseif lengthPass == 17
            if num == 1 && low == 0 && up == 0 && spec == 0 #numbers only
                print("4 weeks")
            elseif num == 0 && low == 1 && up == 0 && spec == 0 #lower only
                print("800,000 years")
            elseif num == 0 && low == 1 && up == 1 && spec == 0 #lower + upper
                print("100 BILLION years")
            elseif num == 1 && low == 1 && up == 1 && spec == 0 # lower + upper + number
                print("2 TRILLION years")
            elseif num == 1 && low == 1 && up == 1 && spec == 1 # all
                print("93 TRILLION years")
            end
        elseif lengthPass > 18
            if num == 1 && low == 0 && up == 0 && spec == 0 #numbers only
                print("9 months")
            elseif num == 0 && low == 1 && up == 0 && spec == 0 #lower only
                print("23 MMILLION years")
            elseif num == 0 && low == 1 && up == 1 && spec == 0 #lower + upper
                print("6 TRILLION years")
            elseif num == 1 && low == 1 && up == 1 && spec == 0 # lower + upper + number
                print("100 TRILLION years")
            elseif num == 1 && low == 1 && up == 1 && spec == 1 # all
                print("7 QUADRILLION years")
            end
        end
    elseif answer == "2"
        main_Menu()
    else
        println("Please select a valid input")
        println("Returning to Strength Tester Menu")
        sleep(2)
        password_Test_Strength()

    end
    println(" to crack your password")


    #= Print the after questions =#
    println("Test Sucessful")
    sleep(7)
    clear()
    println("Please select an option to continue...")
    println("1.]Test another password")
    println("2.]Return to Main Menu")

    answer_Suc = 0
    try
        answer_Suc = parse(Int64, Base.prompt("Please select an option"))
    catch
        println("You've selected an invalid option")
        print("Returning to main menu...")
        sleep(2)
        main_Menu()
    end

    if answer_Suc == 1
        password_Test_Strength()
    elseif answer_Suc == 2
        main_Menu()
    else
        println("You've selected an invalid option")
    end
end

#= Function for changing credentials =#
function change_Credentials(credentials)
    #= Input screen =#
    clear()
    println("Changing your credentials")
    println("\n1.] Username")
    println("2.] Password")
    println("3.] Username and Password")
    println("4.] Go back to menu")
    user_Choice = parse(Int64, Base.prompt("What do you want to change"))

    #= If statement for user's choice =#
    if (user_Choice == 1)
        #= Changing username screen =#
        clear()
        print("Your current username is: ")
        println(credentials[1][1])
        print("Enter your new username: ")
        new_Username = readline()
        print("You want to save this change? [Y/N]: ")
        user_Confirm = readline()
        if (user_Confirm == "Y")
            #= After reading the new username, 
                it will then be replaced on the global variable of credentials=#
            credentials_Holder = join([new_Username, credentials[1][2], credentials[1][3], credentials[1][4]], " ")
            credentials[1][1] = new_Username
            #= Then the updated credential array 
                will then be re-write into the file =#
            id = open("id.txt", "w")
            write(id, credentials_Holder)
            close(id)
            main_Menu()
        elseif (user_Confirm == "N")
            #= If user enters N, 
                goes back to change credentials menu =#
            change_Credentials(credentials)
        else
            #= If none, go back to change credentials menu =#
            println("Enter a valid answer...")
            sleep(2)
            change_Credentials(credentials)
        end
    elseif (user_Choice == 2)
        #= Changing password screen =#
        clear()
        print("Your current password is: ")
        println(credentials[1][2])
        print("Enter your new password: ")
        new_Password = readline()
        print("Enter a new hint: ")
        new_Hint = readline()
        print("You want to save this change? [Y/N]: ")
        user_Confirm = readline()

        if (user_Confirm == "Y")
            #= After reading the new password and hint, 
                it will then be replaced on the global variable of credentials=#
            credentials_Holder = join([credentials[1][1], new_Password, new_Hint, credentials[1][4]], " ")
            credentials[1][2] = new_Password
            credentials[1][3] = new_Hint
            #= Then the updated credential array 
                will then be re-write into the file =#
            id = open("id.txt", "w")
            write(id, credentials_Holder)
            close(id)
            main_Menu()
        elseif (user_Confirm == "N")
            #= If user enters N, 
                goes back to change credentials menu =#
            change_Credentials(credentials)
        else
            #= If none, go back to change credentials menu =#
            println("Enter a valid answer...")
            sleep(2)
            change_Credentials(credentials)
        end
    elseif (user_Choice == 3)
        #= Changing username and password screen =#
        clear()
        print("Your current username is: ")
        println(credentials[1][1])
        print("Your current password is: ")
        println(credentials[1][2])
        print("Enter your new username: ")
        new_Username = readline()
        print("Enter your new password: ")
        new_Password = readline()
        print("Enter a new hint: ")
        new_Hint = readline()
        print("You want to save this change? [Y/N]: ")
        user_Confirm = readline()

        if (user_Confirm == "Y")
            #= After reading the new username, password, and hint, 
                it will then be replaced on the global variable of credentials =#
            credentials_Holder = join([new_Username, new_Password, new_Hint, credentials[1][4]], " ")
            credentials[1][1] = new_Username
            credentials[1][2] = new_Password
            credentials[1][3] = new_Hint
            #= Then the updated credential array 
                will then be re-write into the file =#
            id = open("id.txt", "w")
            write(id, credentials_Holder)
            close(id)
            main_Menu()
        elseif (user_Confirm == "N")
            #= If user enters N, 
                goes back to change credentials menu =#
            change_Credentials(credentials)
        else
            #= If none, go back to change credentials menu =#
            println("Enter a valid answer...")
            sleep(2)
            change_Credentials(credentials)
        end
    elseif (user_Choice == 4)
        main_Menu()
    else
        println("\nInvalid input...")
        print("Going back to menu...")
        sleep(3)
        change_Credentials(credentials)
    end
end

#= Function for logging in =#
function login()
    #= Initialize 3 tries maximum =#
    global attempts = 3

    #= Read the text file and put into credentials array =#
    open("id.txt") do f
        while !eof(f)
            # read a new / next line for every iteration          
            line = readline(f)
            push!(credentials, split(line, " "))
        end
    end

    #= While not exceeding attemptm, do =#
    while (attempts > 0)
        #= Output log in screen =#
        clear()
        println("Welcome to Password Manager")
        println("Please login")
        print("Username: ")
        read_Id = readline()
        print("Password: ")
        read_Password = readline()

        #= If username and passwords are correct,
            go to reminder =#
        if (read_Id == credentials[1][1] && read_Password == credentials[1][2])
            reminder()
            main_Menu()
            break
        end

        #= If not, minus one the attempt =#
        global attempts -= 1

        #= Notify user that credentials are wrong,
            print the given hint =#
        println("\nUsername or Password do not match.")
        println("Please enter again.")
        print("You have ")
        print(attempts)
        print(" tries left or the system will close")
        print("\n\nThe hint is: ")
        print(credentials[1][3])
        sleep(2)
    end
end

#= Function for password reminder =#
function reminder()
    clear()
    println("\n\n\tChecking for reminders...")
    sleep(5)

    #= Initialize variables =#
    number_of_Passwords = 0
    password_Holder = Any[]
    converted_Date = Date[]
    temp_Holder = Any[]

    #= Read the id text and put it in temp_Holder =#
    open("id.txt") do f
        while !eof(f)
            line = readline(f)
            push!(temp_Holder, split(line, " "))
        end
    end

    #= The file containts the following format:
        "username" "password" "hint" "status" =#

    #= If the status is 0, meaning there is no password to read,
        continue to main menu =#
    if (temp_Holder[1][4] == "0")
        main_Menu()
    end

    #= Else, read the text file, and push into password holder and 
        count the number of passwords =#
    open("password.txt") do f
        while !eof(f)
            # read a new / next line for every iteration          
            line = readline(f)
            number_of_Passwords += 1
            push!(password_Holder, split(line, " "))
        end
        if (eof(f))
            return
        end
    end

    #= For every date in the password file,
        convert the string into Date type =#
    for i in 1:number_of_Passwords
        push!(converted_Date, parse(Date, password_Holder[i][3]))
    end

    #= Reiterate the converted Date and 
        check if this is more than 3 months from today's date, 
            if more than, print the following outputs =#
    for i in 1:number_of_Passwords
        if (converted_Date[i] < (Date(today()) - Dates.Month(3)))
            println("\n\nPlease update the following passwords: ")
            print(password_Holder[i][1] * "  ")
            println(password_Holder[i][3])
            sleep(1)
        end
    end
    sleep(6)
end

#= Function for exit message =#
function exit_Message()
    #= Print the creators and the professor =#
    clear()
    println("------------------PASSWORD MANAGER-----------------")
    sleep(0.25)

    println("\n-------------------SUBMITTED BY--------------------")
    sleep(0.25)
    println("---------------LANCE LURANCE SEDUTAN----------------")
    sleep(0.25)
    println("----------------MHARK ANGELO MICLAT----------------")
    sleep(0.25)
    println("--------------CHARLES TRISTAN ARANDA---------------")
    sleep(0.25)
    println("-----------------ANJELO PITAGAN--------------------")
    sleep(0.25)

    println("\n-------------------SUBMITTED TO--------------------")
    sleep(0.25)
    println("------------PROF.PRISCILLA SOTELO-BATOR------------")
    sleep(0.25)
    println("---------------------------------------------------")
    sleep(0.25)
    println("-----THANK YOU FOR USING OUR PASSWORD MANAGER!-----")
    sleep(0.25)
end

#= Start the application =#
login()