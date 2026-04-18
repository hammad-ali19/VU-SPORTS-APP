from flask_mailman import EmailMessage
from email_validator import validate_email, EmailNotValidError

ALLOWED_DOMAINS = {"gmail.com", "vu.edu.pk"}

def send_email(sub, body, receiver_list, sender='bc220401578hal@vu.edu.pk'):
    valid_emails = []

    for e in receiver_list:
        try:
            valid = validate_email(e)
            normalized_email = valid.email
            domain = normalized_email.split("@")[1]

            if domain not in ALLOWED_DOMAINS:
                print(f"Rejected domain: {domain}")
                continue

            valid_emails.append(normalized_email)

        except EmailNotValidError as err:
            print(f"Invalid: {str(err)}")

    if not valid_emails:
        print("No valid emails found")
        return
    else:
        print("Email sent successfully")
    
    msg = EmailMessage(
        subject=sub,
        body=body,
        from_email=sender,
        to=valid_emails
    )
    msg.send()