from behave import given, when, then
import requests
from requests.exceptions import HTTPError

# You can modify this URL to your product admin's URL
BASE_URL = "http://localhost:8000/products"

@given('the following products')
def step_impl(context):
    products = [
        {"name": "Hat", "description": "A red fedora", "price": 59.95, "available": True, "category": "Cloths"},
        {"name": "Shoes", "description": "Running shoes", "price": 89.99, "available": False, "category": "Sports"},
        {"name": "Big Mac", "description": "Fast food item", "price": 5.99, "available": True, "category": "Food"},
        {"name": "Sheets", "description": "Bed sheets", "price": 29.99, "available": True, "category": "Home"},
    ]
    context.products = products

@when(u'I select "{value}" in the "{dropdown}" dropdown')
def step_impl(context, value, dropdown):
    # Implementasi untuk memilih value dalam dropdown
    dropdown_element = context.driver.find_element_by_name(dropdown)
    select = Select(dropdown_element)
    select.select_by_visible_text(value)


@when('I set the "{field}" to "{value}"')
def step_impl(context, field, value):
    context.data = context.data or {}
    context.data[field] = value

@when('I select "{value}" in the "{field}" dropdown (api)')
def step_impl(context, value, field):
    context.data[field] = value

@when('I press the "{button}" button')
def step_impl(context, button):
    if button == "Create":
        response = requests.post(BASE_URL, json=context.data)
        context.resp = response
    elif button == "Search":
        response = requests.get(BASE_URL, params=context.data)
        context.resp = response
    elif button == "Update":
        response = requests.put(f"{BASE_URL}/{context.data['name']}", json=context.data)
        context.resp = response
    elif button == "Delete":
        response = requests.delete(f"{BASE_URL}/{context.data['name']}")
        context.resp = response
    context.data = {}

@then('I should see the message "{message}"')
def step_impl(context, message):
    if context.resp.status_code == 200:
        assert message in context.resp.text

@then('I should see "{value}" in the "{field}" api field')
def step_impl(context, value, field):
    assert value in context.resp.json().get(field, '')


@then('I should see "{value}" in the results')
def step_impl(context, value):
    assert value in context.resp.text

@then('I should not see "{value}" in the results')
def step_impl(context, value):
    assert value not in context.resp.text
