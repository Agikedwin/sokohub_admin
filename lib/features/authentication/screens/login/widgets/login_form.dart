
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:sokohub_admin/features/persionalizations/controllers/login_controller.dart';
import 'package:sokohub_admin/routes/routes.dart';
import 'package:sokohub_admin/utils/constants/sizes.dart';
import 'package:sokohub_admin/utils/constants/text_strings.dart';
import 'package:sokohub_admin/utils/validators/validation.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LoginController());
    return Form(
      key: controller.loginFormKey,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: TSizes.spaceBtwSections),
        child: Column(
          children: [
            // Email
            TextFormField(
              controller: controller.email,
              validator:  (value) => TValidator.validateEmail(value),
              decoration:  InputDecoration(
                labelText: TTexts.email,
                prefixIcon: Icon(Iconsax.direct_right),
              ),
            ),
            const SizedBox(height: TSizes.spaceBtwInputFields,),
    
            // Password
            Obx(
              () => TextFormField(
                controller: controller.password,
                validator:  (value) => TValidator.validateEmptyText('Password', value),
                obscureText: controller.hidePassword.value,
                decoration:  InputDecoration(
                  labelText: TTexts.password,
                  
                  prefixIcon: Icon(Iconsax.password_check),
                  suffixIcon: IconButton(onPressed:  () => controller.hidePassword.value = !controller.hidePassword.value, 
                  icon: Icon(controller.hidePassword.value ? Iconsax.eye_slash : Iconsax.eye))
                ),
              ),
            ),
            const SizedBox(height: TSizes.spaceBtwInputFields / 2,),
    
            // Remeber me and forget password
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                /// Remember me
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Obx(() => Checkbox(value: controller.remembeMe.value, onChanged: (value) => controller.remembeMe.value = value!)),
                    Text(TTexts.rememberMe)
                  ],
    
                ),
                /// Forget Password
                
                TextButton(onPressed: (){
                  
                  Get.toNamed(ITRoutes.forgetPassword);
                }, child: Text(TTexts.forgetPassword))
                
              ],
            ),
            const  SizedBox(height: TSizes.spaceBtwSections,),
    
            ///Sign in button
            SizedBox(
              width: double.infinity,
              //child: ElevatedButton(onPressed: () => controller.resisterAdmin(), child: Text(TTexts.signIn)),
              child: ElevatedButton(onPressed: () => controller.emailAndPasswordSignIn(), child: Text(TTexts.signIn)),
            )
    
    
          ],
        ),
      )
    );
  }
}