import '../../../core/enums/user_role.dart';

class AgreementClause {
  const AgreementClause({
    this.label,
    required this.body,
    this.subPoints = const [],
  });

  final String? label;
  final String body;
  final List<String> subPoints;
}

class RoleAgreementContent {
  const RoleAgreementContent({
    required this.title,
    required this.intro,
    required this.clauses,
    required this.acceptanceText,
  });

  final String title;
  final String intro;
  final List<AgreementClause> clauses;
  final String acceptanceText;

  static RoleAgreementContent forRole(UserRole role) {
    return switch (role) {
      UserRole.tailor => tailor,
      UserRole.customer => customer,
      UserRole.shopkeeper => shopkeeper,
    };
  }

  static const tailor = RoleAgreementContent(
    title: 'Tailor Agreement',
    intro:
        'SmartStitch Tailor Registration & Work Rules for quick and easy reference:',
    clauses: [
      AgreementClause(
        label: 'Registration Fee',
        body:
            'A payment of Rs. 2,000 is required for account verification.',
      ),
      AgreementClause(
        label: 'Required Details',
        body:
            'You must submit an accurate CNIC, phone number, address, and your portfolio.',
      ),
      AgreementClause(
        label: 'Account Performance',
        body:
            'Delivering timely work and earning good ratings will improve your search ranking. Conversely, poor service, delays, fake information, or rule violations will result in warnings, wallet deductions, suspension, or an account block.',
      ),
      AgreementClause(
        label: 'Creation & Deductions',
        body:
            'SmartStitch will set up a dedicated tailor wallet/security balance. 10% will be deducted from each order you complete until this balance reaches Rs. 10,000.',
      ),
      AgreementClause(
        label: 'Purpose',
        body:
            'This balance remains untouched and is only used for customer compensation if you completely damage a dress and the issue cannot be resolved after an official proof review.',
      ),
      AgreementClause(
        label: 'Accuracy',
        body:
            'Stitch strictly according to the customer\'s uploaded design, measurement table, and written description.',
      ),
      AgreementClause(
        label: 'Quality',
        body:
            'Keep all stitching neat, clean, and strong. Ensure you overlock the dress where required.',
      ),
      AgreementClause(
        label: 'Alteration Margin',
        body:
            'Leave an extra 1-2 inches of fabric inside where possible to allow for future customer alterations.',
      ),
      AgreementClause(
        label: 'Deadlines',
        body:
            'Every order must be completed within the specific timeframe stated in the quotation.',
      ),
      AgreementClause(
        label: 'Communication Channel',
        body:
            'You must only use the SmartStitch chat to communicate with customers. This ensures a formal record is kept for any future reference.',
      ),
      AgreementClause(
        label: 'Errors',
        body:
            'If there are minor fitting or stitching mistakes, you must provide the customer with free alterations.',
      ),
      AgreementClause(
        label: 'Major Damage',
        body:
            'For completely ruined dresses, compensation may be deducted directly from your security wallet.',
      ),
      AgreementClause(
        label: 'Dispute Resolution',
        body:
            'If a dispute arises, you must submit your proof. The SmartStitch Admin will make a final decision after reviewing the customer\'s proof, your proof, the original measurements, the design, and the chat history.',
      ),
    ],
    acceptanceText:
        'By clicking \'I Agree\', you formally accept all of the registration, payment, stitching, delivery, dispute, and quality rules outlined above by SmartStitch.',
  );

  static const customer = RoleAgreementContent(
    title: 'Customer Agreement',
    intro: 'SmartStitch Customer Rules for quick and easy reference:',
    clauses: [
      AgreementClause(
        body:
            'Customer must create an account using correct name, phone number, and address information.',
      ),
      AgreementClause(
        body:
            'Customer must upload clear dress design images, measurements, fabric details, and stitching requirements before placing an order.',
      ),
      AgreementClause(
        body:
            'Customer must pay 50% advance payment to confirm the order.',
      ),
      AgreementClause(
        body:
            'Remaining payment must be paid according to the selected payment method (COD or online payment).',
      ),
      AgreementClause(
        body:
            'Customer is responsible for providing accurate measurements. SmartStitch is not responsible for issues caused by incorrect measurements provided by the customer.',
      ),
      AgreementClause(
        body:
            'Customer should clearly mention all stitching requirements, style details, and special instructions before order confirmation.',
      ),
      AgreementClause(
        body:
            'Customer must communicate with the tailor through SmartStitch chat to maintain an official record.',
      ),
      AgreementClause(
        body:
            'Customer should inspect the delivered dress within the specified review period.',
      ),
      AgreementClause(
        body:
            'If any stitching, fitting, or quality issue occurs, the customer may submit a dispute request through SmartStitch.',
      ),
      AgreementClause(
        body: 'Dispute claims must include proper evidence such as:',
        subPoints: [
          'Dress photos',
          'Design reference photos',
          'Chat records',
          'Measurement details',
          'Any other relevant proof',
        ],
      ),
      AgreementClause(
        body:
            'SmartStitch admin will review customer proof, tailor proof, order details, measurements, and chat records before making a final decision.',
      ),
      AgreementClause(
        body:
            'Minor fitting issues may require alteration before compensation is considered.',
      ),
      AgreementClause(
        body:
            'False complaints, fake evidence, misuse of the dispute system, or attempts to damage a tailor\'s reputation may result in account warnings, suspension, or permanent blocking.',
      ),
      AgreementClause(
        body:
            'Customer ratings and reviews should be honest, fair, and based on actual order experience.',
      ),
      AgreementClause(
        body:
            'SmartStitch acts as a platform connecting customers and tailors and will make decisions based on available evidence and platform policies.',
      ),
    ],
    acceptanceText:
        'By clicking \'I Agree\', the customer accepts all SmartStitch payment, delivery, stitching, dispute, review, and platform rules.',
  );

  static const shopkeeper = RoleAgreementContent(
    title: 'Shopkeeper Agreement',
    intro:
        'SmartStitch Shopkeeper Registration & Marketplace Rules for quick and easy reference:',
    clauses: [
      AgreementClause(
        body:
            'Shopkeeper must pay a Rs. 2,000 registration fee for account verification.',
      ),
      AgreementClause(
        body:
            'Shopkeeper must provide correct CNIC, phone number, shop address, and business information during registration.',
      ),
      AgreementClause(
        body:
            'SmartStitch will create a shopkeeper wallet/security balance for each shopkeeper.',
      ),
      AgreementClause(
        body:
            'SmartStitch will deduct 10% from every shopkeeper order until the wallet balance reaches Rs. 10,000.',
      ),
      AgreementClause(
        body:
            'This security balance may be used if the shopkeeper delivers the wrong material, damaged material, poor-quality material, fake material, or fails to resolve a verified customer complaint after proof review.',
      ),
      AgreementClause(
        body: 'Shopkeeper must upload clear and genuine product images.',
      ),
      AgreementClause(
        body: 'Shopkeeper must provide accurate information regarding:',
        subPoints: [
          'Fabric type',
          'Material quality',
          'Color',
          'Size/length',
          'Price',
          'Brand (if applicable)',
          'Product description',
        ],
      ),
      AgreementClause(
        body:
            'Shopkeeper must deliver the same material that is displayed and described in the SmartStitch listing.',
      ),
      AgreementClause(
        body:
            'Shopkeeper must properly pack products to avoid damage during delivery.',
      ),
      AgreementClause(
        body:
            'Shopkeeper must dispatch and deliver orders within the promised time period.',
      ),
      AgreementClause(
        body:
            'Shopkeeper must communicate with customers only through SmartStitch chat for proper record keeping.',
      ),
      AgreementClause(
        body:
            'Shopkeepers have the right to submit their own proof, including:',
        subPoints: [
          'Product photos before dispatch',
          'Packing proof',
          'Delivery proof',
          'Chat records',
          'Any other relevant evidence',
        ],
      ),
      AgreementClause(
        body:
            'SmartStitch Admin will review customer proof, shopkeeper proof, order details, product listing information, and chat records before making a final decision.',
      ),
      AgreementClause(
        body:
            'If the shopkeeper is found responsible for the issue, compensation, replacement, refund, or wallet deduction may be applied according to SmartStitch policies.',
      ),
      AgreementClause(
        body:
            'False information, fake listings, repeated complaints, delayed deliveries, poor-quality products, or rule violations may result in warnings, wallet deductions, suspension, or permanent account blocking.',
      ),
      AgreementClause(
        body:
            'Shopkeepers with good ratings, positive customer reviews, accurate product listings, and timely deliveries may appear at the top of search results.',
      ),
      AgreementClause(
        body:
            'SmartStitch uses third-party courier services for delivery. However, the shopkeeper remains responsible for providing the correct product and proper packaging.',
      ),
    ],
    acceptanceText:
        'By clicking \'I Agree\', the shopkeeper accepts all SmartStitch registration, payment, product quality, delivery, dispute resolution, security wallet, and marketplace rules.',
  );
}
