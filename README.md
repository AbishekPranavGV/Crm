CRM PROJECT HANDOVER — CONTEXT

My Role

I am currently undergoing job training as an AI Prompt Engineer at Nunes Instrument.

I am working on a CRM/business automation project using AI.

I am a beginner in Google Apps Script, so technical explanations and implementation should be clear, incremental, and testable.

---

PROJECT OBJECTIVE

I am building/automating a CRM system.

The CRM should eventually manage business processes such as:

Product Management
→ Buyer Management
→ Lead Management
→ Communication
→ Quotations
→ Orders
→ Documents
→ Follow-ups
→ Reporting

The current development priority is Product Master + Communication Automation.

---

CURRENT TECHNOLOGY

Currently using:

- Google Sheets
- Google Drive
- Google Apps Script
- Gmail
- Windows Batch
- AI/LLM tools
- WhatsApp / WhatsApp integration where technically available

Google Drive is already linked with the CRM.

The CRM should allow users to access/select Drive files directly rather than manually leaving the CRM.

---

CURRENT MODULE: PRODUCT MASTER

The current focus is the Product List / Product Master.

The Product Master should act as the central source of product information.

Possible information includes:

- Product ID
- Product name
- SKU
- Category
- Sub-category
- Description
- Product variants
- Product images
- Product PDF/catalogue
- Supplier
- Pricing
- MOQ
- Market
- Status
- Google Drive File ID

Do not unnecessarily duplicate product information in other CRM modules.

---

CURRENT COMMUNICATION REQUIREMENT

One of the most important features is a Communication Composer inside the CRM.

The user should be able to select:

1. Buyer
2. Communication channel
3. Email/message template
4. One or more products
5. One or more files from Google Drive
6. Company location
7. Whether to include file links
8. Whether to include QR code

Then the CRM should generate a preview before sending.

---

FILE SELECTION

The user should be able to select:

- PDFs
- Images
- Catalogues
- Brochures
- Other relevant documents

Multiple files should be selectable.

Selected files should appear in the CRM as preview cards/images where practical.

The user should be able to:

- Add files
- Remove files
- Review selected files
- See the associated filename
- Confirm the files before sending

---

GOOGLE DRIVE

Google Drive is already connected to the CRM.

For reliable file identification, prefer storing:

Google Drive File ID

rather than relying only on filenames.

Example:

Product
→ Document ID
→ Google Drive File ID

The system should retrieve the exact file using its File ID.

Do not make the system guess attachments based only on filenames.

---

FILE ATTACHMENT + FILE LINK

The communication system may need to support BOTH:

1. Actual attachment

The selected PDF/file is attached to the Gmail message.

2. File link

A clickable link to the relevant file/document can also be included in the message where appropriate.

These should be treated as separate functions.

---

EMAIL TEMPLATE SYSTEM

Email templates should be stored separately from Apps Script.

Each template should have a unique Template ID.

Example:

TEMPLATE-001
TEMPLATE-002
TEMPLATE-FOLLOWUP-001

Templates may contain dynamic variables such as:

{{BUYER_NAME}}
{{COMPANY_NAME}}
{{PRODUCT_NAME}}
{{QUANTITY}}
{{COUNTRY}}

The system should replace these variables before sending.

Do not hard-code every email template inside the Apps Script.

---

CURRENT GMAIL PROBLEM

The major difficulty currently being faced is:

Reliably sending the exact intended email template + exact intended PDF/file + exact intended recipient through Gmail.

The system must prevent accidental mismatches.

The intended relationship is:

Buyer ID
→ Email Address

Template ID
→ Exact Template

Document/File ID
→ Exact Attachment

Product ID
→ Product information

Before sending, validate all of these.

If validation fails:

DO NOT SEND.

Instead show/log the error.

---

COMMUNICATION PREVIEW

The CRM should have a preview similar to:

COMMUNICATION COMPOSER

Buyer:
[Selected Buyer]

Email:
[Buyer Email]

Channel:
[Gmail / WhatsApp]

Template:
[Selected Template]

Products:
[Selected Products]

Files:
[Selected Files]

Location:
[Selected Location]

Options:
☑ Include file links
☑ Include QR code

---

PREVIEW

Subject:
[Generated subject]

Email/message body:

Dear [Buyer],

[Personalized content]

[Selected files/links]

[Location information]

[QR CODE]

---

Actions:

[Send Gmail]

[Send WhatsApp]

[Save Draft]

---

COMPANY LOCATIONS + QR CODES

The CRM has three company locations.

The user should select the desired company location from the CRM.

Example:

Location 1
Location 2
Location 3

Each location should have its own:

- Location ID
- Location name
- Address
- Google Maps URL
- QR code
- QR Google Drive File ID if applicable
- Status

Recommended structure:

Location ID
→ Location details
→ Maps URL
→ QR code

The CRM should retrieve the correct QR code based on the selected Location ID.

Do not generate or select the QR randomly.

---

LOCATION OUTPUT

If the user selects a location and enables QR:

The final communication should include the relevant location information and QR code.

Example:

Visit our location:

[Location Name]

[Address]

[QR CODE]

The QR should correspond exactly to the selected location.

---

GMAIL + WHATSAPP ARCHITECTURE

The CRM interface can have:

[Send Gmail] [Send WhatsApp]

However, Gmail and WhatsApp should be treated as separate communication channels.

Do not assume Gmail HTML can simply be copied into WhatsApp.

Use:

Communication Data
→ Channel
→ Channel-specific renderer
→ Send

---

RECOMMENDED DATA STRUCTURE

At minimum, consider:

Products
Buyers
Documents
Email_Templates
Locations
Outreach
Communication_Log
Settings

Possible relationship:

Product
→ Documents

Buyer
→ Outreach

Outreach
→ Product

Outreach
→ Template

Outreach
→ Documents

Outreach
→ Location

Outreach
→ Communication Log

---

OUTREACH RECORD

Each communication attempt should have a unique Outreach ID.

Example fields:

Outreach ID
Buyer ID
Product ID
Template ID
Document ID(s)
Location ID
Channel
Recipient
Subject
Status
Created Date
Sent Date
Error
Follow-up Date

Possible statuses:

DRAFT
PENDING
VALIDATING
SENT
FAILED
RETRY

Never mark an email as SENT before the send operation actually succeeds.

---

AI ROLE

AI should help with:

- Template recommendation
- Email personalization
- Product recommendation
- Buyer requirement analysis
- Lead classification
- Lead scoring
- Communication summarization
- Follow-up recommendations
- Document classification
- Product matching

However, AI should NOT freely decide critical business information at send time.

Critical fields such as:

- Recipient
- Attachment
- Product
- Price
- Order
- Payment

should be controlled/validated by deterministic CRM rules.

---

DEVELOPMENT PRINCIPLE

Do not build the entire CRM at once.

Work incrementally.

Recommended order:

1. Understand current system
2. Product Master
3. Drive/File mapping
4. Email Template system
5. Location/QR system
6. Communication Composer
7. Gmail automation
8. WhatsApp integration
9. Communication logging
10. AI capabilities
11. Reporting/dashboard
12. Security/testing

---

HOW CHATGPT SHOULD HELP ME

Act as:

- CRM Solution Architect
- Business Analyst
- AI Automation Engineer
- Google Apps Script Developer
- Workflow Designer
- Database Designer
- Prompt Engineer

Before writing large amounts of code:

1. Understand the requirement.
2. Identify missing information.
3. Explain the architecture.
4. Recommend the approach.
5. Break the implementation into small steps.
6. Give testable code.
7. Tell me exactly where to place the code.
8. Explain how to configure it.
9. Give test cases.
10. Help debug errors.
11. Maintain consistency with previous architectural decisions.

I am a beginner in Apps Script.

Do not give me unnecessarily complex code.

Do not replace my existing implementation without first explaining why.

---

IMPORTANT

This is an ongoing project.

When I provide screenshots, existing Google Sheets columns, Apps Script code, errors, or CRM UI details, treat them as the current implementation and build upon them.

Do not assume that the current system should be rebuilt from scratch.

The immediate objective is:

Make Product Master + Drive File Selection + Template Selection + Location Selection + Gmail Sending reliable.

The most important current problem is:

Exact recipient + exact template + exact selected file(s) + exact location QR → reliable preview → Gmail/WhatsApp sending → communication log.

Start by reviewing this architecture and tell me what information you need from my current CRM before implementation.